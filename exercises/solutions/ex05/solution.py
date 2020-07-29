import numpy as np
import random


class RaceTrackEnv:
    """
    RaceTrackEnv object maintains and updates the race track 
    state. Interaction with the class is through
    the step() method (see OpenAI Gym interface)
    
    The class constructor is given a race course as a list of 
    strings. The constructor loads the course and initializes 
    the environment state.
    """
    
    lbl2int = {'o': 1, '-': 0, '+': 2, 'W': -1}
    
    def __init__(self, course):
        """
        Load race course, set any min or max limits in the 
        environment (e.g. max speed), and set initial state.
        Initial state is random position on start line with 
        velocity = (0, 0).
        
        Example:
            tiny_right_turn_course = 
                  ['WWWWWW',
                   'Woooo+',
                   'Woooo+',
                   'WooWWW',
                   'WooWWW',
                   'WooWWW',
                   'WooWWW',
                   'W--WWW',]
        
        Args:
            course: List of text strings used to construct
                race-track.
                    '-': start line
                    '+': finish line
                    'o': track
                    'W': wall
        
        Returns:
            self
        """
        self.MAX_VELOCITY = 5
        self.start_positions = []
        self.course = None
        self._load_course(course)
        self._random_start_position()
        self.velocity = np.array([0, 0], dtype=np.int8)
        self.bounds = (len(course), len(course[0]))


    def step(self, action):
        """
        Perform given action on the environment.
        The reward for every action and state is -1, except for when 
        reaching the finish line.
        
        Args:
            action: integer-encoded {0-8} or a 
                2-tuple (a_y, a_x) in {[-1, 0, 1], [-1, 0, 1]}.
        
        Returns:
            4-tuple: (new_state, reward, done, info)
                new_state: the new state resulting from taken action
                reward: The reward obtained from taken action
                done: Bool. Whether we are in a terminal state.
                Info: Dict. Arbitrary information.
                
        """
        ### BEGIN SOLUTION
        if not isinstance(action, tuple):
            action = self.action_to_tuple(action)
        
        reward = -1.0
        done = False
        if self.is_terminal_state():
            reward = 0
            done = True
        else:
            # update velocity
            self.velocity += np.array(action, dtype=np.int8)
            self.velocity = np.clip(self.velocity, -self.MAX_VELOCITY, self.MAX_VELOCITY)
            # project jump to new position virtually
            projected_path_y = np.clip(
                np.around(np.linspace(self.position[0], 
                                      self.position[0] + self.velocity[0],
                                      self.MAX_VELOCITY*2),
                          decimals=1).astype(int), 
                0, self.bounds[0]-1)
            projected_path_x = np.clip(
                np.around(np.linspace(self.position[1], 
                                      self.position[1] + self.velocity[1],
                                      self.MAX_VELOCITY*2),
                          decimals=1).astype(int),
                0, self.bounds[1]-1)
            projected_steps = list(self.course[projected_path_y, projected_path_x])
            # hits finish line?
            if self.lbl2int['+'] in projected_steps:
                # has grass been hit before?
                if self.lbl2int['W'] in projected_steps:
                    s = self.reset()
                    if projected_steps.index(self.lbl2int['+']) < projected_steps.index(self.lbl2int['W']):
                        # finished and hit grass afterwards
                        done = True
                else:
                    # clean finish
                    self.position += self.velocity
                    s = self.get_state()
                    done = True
            # hits grass?
            elif self.lbl2int['W'] in projected_steps:
                s = self.reset()
            else:
                self.position += self.velocity
                s = self.get_state()
        return s, reward, done, {}
        ### END SOLUTION

    def get_state(self):
        """Return 2-element-tuple: (position, velocity). Each is a 2D numpy array."""
        return self.position.copy(), self.velocity.copy()
            
            
    def reset(self):
        """Set velocity to 0 in both directions and set the position to any
        of the possible start positions.
        Returns the resulting state."""
        ### BEGIN SOLUTION
        self._random_start_position()
        self.velocity = np.array([0, 0], dtype=np.int8)
        ### END SOLUTION
        return self.get_state()

    def _random_start_position(self):
        """Set agent to random position on start line."""
        ### BEGIN SOLUTION
        self.position = np.array(random.choice(self.start_positions),
                                dtype=np.int8)
        ### END SOLUTION
    
    def _load_course(self, course):
        """Load given course. The course is expected to be a list of strings.
        Each string represents a horizontal line of the track.
        See __init__ doc.
        The course is to be internally represented as numpy array."""
        ### BEGIN SOLUTION
        y_size, x_size = len(course), len(course[0])
        self.course = np.zeros((y_size, x_size), dtype=np.int8)
        
        for y in range(y_size):
            self.course[y, :] = np.array([self.lbl2int[i] for i in course[y]], dtype=np.int8)
        
        self.start_positions = [(i,j) for i,j in zip(*np.where(self.course == self.lbl2int['-']))]                
        ### END SOLUTION

    def _is_finish(self, pos):
        """Return True if given position is in finish line"""
        ### BEGIN SOLUTION
        return self.course[pos[0], pos[1]] == self.lbl2int['+']
        ### END SOLUTION
    
    def is_terminal_state(self):
        """Return True at episode terminal state"""
        return self._is_finish(self.position)
    
    
    def action_to_tuple(self, a):
        """Convert integer action to 2-tuple: (ay, ax)"""
        ### BEGIN SOLUTION
        ay = a // 3 - 1
        ax = a % 3 - 1
        
        return ay, ax
        ### END SOLUTION
    
    def tuple_to_action(self, a):
        """Convert 2-tuple to integer action: {0-8}.
        Since there are two axes that can go forward, backward or 
        idle, we have 3² actions"""
        ### BEGIN SOLUTION
        return int((a[0] + 1) * 3 + a[1] + 1)
        ### END SOLUTION
    
    def state_action(self, s, a):
        """Build a state-action tuple for indexing Q NumPy array."""
        if not isinstance(a, tuple):
            a = self.action_to_tuple(a)
        p, v = s
        s_y, s_x = p[0], p[1]
        s_vy, s_vx = v[0], v[1]
        a_y, a_x = a[0]+1, a[1]+1
        return s_y, s_x, s_vy, s_vx, a_y, a_x
    
    def render():
        """Render the current position of the agent within the track text-based"""
        ### BEGIN SOLUTION
        pass
        ### END SOLUTION
