"""Exercise 4.7 (corresponds to example 4.2 and figure 4.2)."""
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns
from scipy.stats import poisson
from joblib import delayed, Parallel

LAMBDA_REQUESTS_1st_LOC = 3
LAMBDA_REQUESTS_2nd_LOC = 4
LAMBDA_RETURNS_1st_LOC = 3
LAMBDA_RETURNS_2nd_LOC = 2

N_DAYS = 100
MAX_CARS_PER_LOC = 20
MAX_MOVABLE_CARS = 5
CREDIT_PER_CAR = 10
COST_PER_CAR_MOVE = 2
COSTS_OF_2nd_PARKINGLOT = 4
POISSON_UPPER_BOUND = 11
ACTIONS = np.arange(-MAX_MOVABLE_CARS, MAX_MOVABLE_CARS + 1)
DISCOUNT = 0.9
poisson_cache = {}

"""The following Flag enables the additional challenges in Jacks car rental 
problem: 
 - One of Jacks employees can drive a car from 1st to 2nd location for free.
 - Limited parking space. More than 10 cars at once after moving and staying 
    over night costs additional 4$ one-time-fee.
 - """
EX_4_7_EXTRAS = True


def poisson_prob(n, lam):
    # global poisson_cache
    key = n * 10 + lam
    if key not in poisson_cache:
        poisson_cache[key] = poisson.pmf(n, lam)
    return poisson_cache[key]


def expected_return(state, action, state_values):
    """
    @state: [# of cars in first location, # of cars in second location]
    @action: positive if moving cars from first location to second location,
            negative if moving cars from second location to first location
    @stateValue: state value matrix
    @constant_returned_cars:  if set True, model is simplified such that
    the # of cars returned in daytime becomes constant
    rather than a random value from poisson distribution, which will reduce calculation time
    and leave the optimal policy/value state matrix almost the same
    """
    # initialize total return
    returns = 0.0

    # cost for moving cars
    returns -= COST_PER_CAR_MOVE * abs(action)
    if EX_4_7_EXTRAS and action > 0:
        returns += COST_PER_CAR_MOVE

    # moving cars
    num_cars_at_first_loc = min(state[0] - action, MAX_CARS_PER_LOC)
    num_cars_at_second_loc = min(state[1] + action, MAX_CARS_PER_LOC)

    if EX_4_7_EXTRAS and (num_cars_at_first_loc > 10 or
                          num_cars_at_second_loc > 10):
        returns -= COSTS_OF_2nd_PARKINGLOT

    # for the next hypothetical day
    # go through all possible rental requests
    for n_requests_at_1st_loc in range(POISSON_UPPER_BOUND):
        for n_requests_at_2nd_loc in range(POISSON_UPPER_BOUND):
            # probability for current combination of rental requests
            joint_prob_requests = \
                poisson_prob(n_requests_at_1st_loc, LAMBDA_REQUESTS_1st_LOC) * \
                poisson_prob(n_requests_at_2nd_loc, LAMBDA_REQUESTS_2nd_LOC)

            # valid rental requests should be less than actual # of cars
            n_requests_at_1st_loc_allowed = min(n_requests_at_1st_loc,
                                                num_cars_at_first_loc)
            n_requests_at_2nd_loc_allowed = min(n_requests_at_2nd_loc,
                                                num_cars_at_second_loc)

            # get credits for renting
            reward = (n_requests_at_1st_loc_allowed +
                      n_requests_at_2nd_loc_allowed) * CREDIT_PER_CAR
            num_cars_at_first_loc_after_reqs = num_cars_at_first_loc -\
                                               n_requests_at_1st_loc
            num_cars_at_second_loc_after_reqs = num_cars_at_second_loc -\
                                                n_requests_at_2nd_loc

            # go through all possible rental returns
            for n_returns_at_1st_loc in range(POISSON_UPPER_BOUND):
                for n_returns_at_2nd_loc in range(POISSON_UPPER_BOUND):
                    joint_prob_returns = \
                        poisson_prob(n_returns_at_1st_loc,
                                     LAMBDA_RETURNS_1st_LOC) *\
                        poisson_prob(n_returns_at_2nd_loc,
                                     LAMBDA_RETURNS_2nd_LOC)
                    num_of_cars_first_loc_ = int(min(
                        num_cars_at_first_loc_after_reqs +
                        n_returns_at_1st_loc,
                        MAX_CARS_PER_LOC))
                    num_of_cars_second_loc_ = int(min(
                        num_cars_at_second_loc_after_reqs +
                        n_returns_at_2nd_loc,
                        MAX_CARS_PER_LOC))
                    prob = joint_prob_requests * joint_prob_returns
                    returns += \
                        prob * (reward + DISCOUNT *
                                state_values[num_of_cars_first_loc_,
                                             num_of_cars_second_loc_])
    return returns


def get_possible_states(state_values):
    indices = np.indices(state_values.shape)
    possible_states = [(a, b) for a, b in zip(indices[0].ravel(),
                                              indices[1].ravel())]
    return possible_states


def policy_evaluation(policy, state_values):

    possible_states = get_possible_states(state_values)

    print('policy evaluation..')
    with Parallel(n_jobs=-1) as prll:
        while True:
            old_state_values = state_values.copy()
            ret = prll(delayed(expected_return)(state=s, action=policy[s],
                                                state_values=state_values)
                       for s in possible_states)
            state_values = np.asarray(ret).reshape(state_values.shape)
            max_value_change = abs(old_state_values - state_values).max()
            print(f'max value change: {max_value_change}')
            if max_value_change < 1e-4:
                break
    return state_values


def expected_return_over_actions_per_state(state, state_values):
    action_returns = np.array(len(ACTIONS) * [-np.inf])
    i, j = state
    for a in ACTIONS:
        if (0 <= a <= i) or (-j <= a <= 0):
            action_returns[ACTIONS == a] = \
                expected_return(state, a, state_values)
    return ACTIONS[np.argmax(action_returns)]


def policy_improvement(policy, state_values):
    old_policy = policy.copy()
    possible_states = get_possible_states(state_values)
    print('policy improvement..')
    with Parallel(n_jobs=-1) as prll:
        ret = prll(delayed(expected_return_over_actions_per_state)
                   (state=s, state_values=state_values)
                   for s in possible_states)
        policy = np.asarray(ret).reshape(policy.shape)
    policy_stable = np.all(old_policy == policy)
    print(f'policy stable: {policy_stable}')
    return policy, policy_stable


def plot_policy(policy, i):
    plt.figure()
    sns.heatmap(policy, cmap="YlGnBu")
    plt.ylabel('# cars at first location')
    plt.xlabel('# cars at second location')
    title = 'state_values' if isinstance(i, str) else f'iter {i}'
    plt.title(title)
    plt.savefig(f'policy_map_{title}.png')


def main():
    state_vals = np.zeros((MAX_CARS_PER_LOC + 1, MAX_CARS_PER_LOC + 1))
    policy_map = np.zeros_like(state_vals)

    iteration = 0
    plot_policy(policy_map, iteration)
    while True:
        state_vals = policy_evaluation(policy_map, state_vals)
        policy_map, policy_is_stable = policy_improvement(policy_map, state_vals)
        iteration += 1
        plot_policy(policy_map, iteration)
        if policy_is_stable:
            break
    plot_policy(state_vals, 'state_values')
    plt.show()


def simulate():
    state = np.array([10, 10])  # initially 10 cars at each location

    requests = np.random.poisson(lam=(LAMBDA_REQUESTS_1st_LOC,
                                      LAMBDA_REQUESTS_2nd_LOC),
                                 size=(N_DAYS, len(state)))

    returns = np.random.poisson(lam=(LAMBDA_RETURNS_1st_LOC,
                                     LAMBDA_RETURNS_2nd_LOC),
                                size=(N_DAYS, len(state)))
    # returned cars available next day only
    returns = np.vstack([np.array((0, 0)), returns[:-1, :]])

    cum_state = []
    for day in range(N_DAYS):
        state += returns[day, :]
        state = np.clip(state, a_min=None, a_max=MAX_CARS_PER_LOC)
        state -= requests[day, :]
        cum_state.append(state.copy())
        # perform actions here
    state = np.vstack(cum_state)
    print(state)


def solution():
    #######################################################################
    # Copyright (C)                                                       #
    # 2016 Shangtong Zhang(zhangshangtong.cpp@gmail.com)                  #
    # 2016 Kenta Shimada(hyperkentakun@gmail.com)                         #
    # 2017 Aja Rangaswamy (aja004@gmail.com)                              #
    # Permission given to modify the code as long as you keep this        #
    # declaration at the top                                              #
    #######################################################################



    #matplotlib.use('Agg')

    # maximum # of cars in each location
    MAX_CARS = 20

    # maximum # of cars to move during night
    MAX_MOVE_OF_CARS = 5

    # expectation for rental requests in first location
    RENTAL_REQUEST_FIRST_LOC = 3

    # expectation for rental requests in second location
    RENTAL_REQUEST_SECOND_LOC = 4

    # expectation for # of cars returned in first location
    RETURNS_FIRST_LOC = 3

    # expectation for # of cars returned in second location
    RETURNS_SECOND_LOC = 2

    DISCOUNT = 0.9

    # credit earned by a car
    RENTAL_CREDIT = 10

    # cost of moving a car
    MOVE_CAR_COST = 2

    # all possible actions
    actions = np.arange(-MAX_MOVE_OF_CARS, MAX_MOVE_OF_CARS + 1)

    # An up bound for poisson distribution
    # If n is greater than this value, then the probability of getting n is truncated to 0
    POISSON_UPPER_BOUND = 11

    # Probability for poisson distribution
    # @lam: lambda should be less than 10 for this function
    poisson_cache = {}

    def poisson_probability(n, lam):
        #global poisson_cache
        key = n * 10 + lam
        if key not in poisson_cache:
            poisson_cache[key] = poisson.pmf(n, lam)
        return poisson_cache[key]

    def expected_return(state, action, state_value, constant_returned_cars):
        """
        @state: [# of cars in first location, # of cars in second location]
        @action: positive if moving cars from first location to second location,
                negative if moving cars from second location to first location
        @stateValue: state value matrix
        @constant_returned_cars:  if set True, model is simplified such that
        the # of cars returned in daytime becomes constant
        rather than a random value from poisson distribution, which will reduce calculation time
        and leave the optimal policy/value state matrix almost the same
        """
        # initailize total return
        returns = 0.0

        # cost for moving cars
        returns -= MOVE_CAR_COST * abs(action)

        # moving cars
        NUM_OF_CARS_FIRST_LOC = min(state[0] - action, MAX_CARS)
        NUM_OF_CARS_SECOND_LOC = min(state[1] + action, MAX_CARS)

        # go through all possible rental requests
        for rental_request_first_loc in range(POISSON_UPPER_BOUND):
            for rental_request_second_loc in range(POISSON_UPPER_BOUND):
                # probability for current combination of rental requests
                prob = poisson_probability(rental_request_first_loc,
                                           RENTAL_REQUEST_FIRST_LOC) * \
                       poisson_probability(rental_request_second_loc,
                                           RENTAL_REQUEST_SECOND_LOC)

                num_of_cars_first_loc = NUM_OF_CARS_FIRST_LOC
                num_of_cars_second_loc = NUM_OF_CARS_SECOND_LOC

                # valid rental requests should be less than actual # of cars
                valid_rental_first_loc = min(num_of_cars_first_loc,
                                             rental_request_first_loc)
                valid_rental_second_loc = min(num_of_cars_second_loc,
                                              rental_request_second_loc)

                # get credits for renting
                reward = (
                                     valid_rental_first_loc + valid_rental_second_loc) * RENTAL_CREDIT
                num_of_cars_first_loc -= valid_rental_first_loc
                num_of_cars_second_loc -= valid_rental_second_loc

                if constant_returned_cars:
                    # get returned cars, those cars can be used for renting tomorrow
                    returned_cars_first_loc = RETURNS_FIRST_LOC
                    returned_cars_second_loc = RETURNS_SECOND_LOC
                    num_of_cars_first_loc = min(
                        num_of_cars_first_loc + returned_cars_first_loc,
                        MAX_CARS)
                    num_of_cars_second_loc = min(
                        num_of_cars_second_loc + returned_cars_second_loc,
                        MAX_CARS)
                    returns += prob * (reward + DISCOUNT * state_value[
                        num_of_cars_first_loc, num_of_cars_second_loc])
                else:
                    for returned_cars_first_loc in range(POISSON_UPPER_BOUND):
                        for returned_cars_second_loc in range(
                                POISSON_UPPER_BOUND):
                            prob_return = poisson_probability(
                                returned_cars_first_loc,
                                RETURNS_FIRST_LOC) * poisson_probability(
                                returned_cars_second_loc, RETURNS_SECOND_LOC)
                            num_of_cars_first_loc_ = min(
                                num_of_cars_first_loc + returned_cars_first_loc,
                                MAX_CARS)
                            num_of_cars_second_loc_ = min(
                                num_of_cars_second_loc + returned_cars_second_loc,
                                MAX_CARS)
                            prob_ = prob_return * prob
                            returns += prob_ * (reward + DISCOUNT *
                                                state_value[
                                                    num_of_cars_first_loc_, num_of_cars_second_loc_])
        return returns

    def figure_4_2(constant_returned_cars=True):
        value = np.zeros((MAX_CARS + 1, MAX_CARS + 1))
        policy = np.zeros(value.shape, dtype=np.int)

        iterations = 0
        _, axes = plt.subplots(2, 3, figsize=(40, 20))
        plt.subplots_adjust(wspace=0.1, hspace=0.2)
        axes = axes.flatten()
        while True:
            fig = sns.heatmap(np.flipud(policy), cmap="YlGnBu",
                              ax=axes[iterations])
            fig.set_ylabel('# cars at first location', fontsize=30)
            fig.set_yticks(list(reversed(range(MAX_CARS + 1))))
            fig.set_xlabel('# cars at second location', fontsize=30)
            fig.set_title('policy {}'.format(iterations), fontsize=30)

            # policy evaluation (in-place)
            while True:
                old_value = value.copy()
                for i in range(MAX_CARS + 1):
                    for j in range(MAX_CARS + 1):
                        new_state_value = expected_return([i, j], policy[i, j],
                                                          value,
                                                          constant_returned_cars)
                        value[i, j] = new_state_value
                max_value_change = abs(old_value - value).max()
                print('max value change {}'.format(max_value_change))
                if max_value_change < 1e-4:
                    break

            # policy improvement
            policy_stable = True
            for i in range(MAX_CARS + 1):
                for j in range(MAX_CARS + 1):
                    old_action = policy[i, j]
                    action_returns = []
                    for action in actions:
                        if (0 <= action <= i) or (-j <= action <= 0):
                            action_returns.append(
                                expected_return([i, j], action, value,
                                                constant_returned_cars))
                        else:
                            action_returns.append(-np.inf)
                    new_action = actions[np.argmax(action_returns)]
                    policy[i, j] = new_action
                    if policy_stable and old_action != new_action:
                        policy_stable = False
            print('policy stable {}'.format(policy_stable))

            if policy_stable:
                fig = sns.heatmap(np.flipud(value), cmap="YlGnBu", ax=axes[-1])
                fig.set_ylabel('# cars at first location', fontsize=30)
                fig.set_yticks(list(reversed(range(MAX_CARS + 1))))
                fig.set_xlabel('# cars at second location', fontsize=30)
                fig.set_title('optimal value', fontsize=30)
                break

            iterations += 1

        plt.savefig('../images/figure_4_2.png')
        plt.show()
        plt.close()

    figure_4_2()


if __name__ == '__main__':
    main()
