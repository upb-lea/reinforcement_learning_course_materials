# SOURCE:
# https://github.com/osannolik/gym-goddard/blob/master/gym_goddard/envs/goddard_env.py
# Distributed under MIT Licence

import gymnasium as gym
import numpy as np

class Rocket(object):

    '''
        Expected parameters and methods of the rocket environment being simulated.
        V0/H0/M0:   Initial velocity/height/weight
        M1:         Final weight (set equal to dry mass if all fuel should be used)
        THRUST_MAX: Maximum possible force of thrust [N]
        GAMMA:      Fuel consumption [kg/N/s]
        DT:         Assumed time [s] between calls to step()
    '''

    V0 = H0 = M0 = M1 = THRUST_MAX = GAMMA = DT = None

    H_MAX_RENDER = None # Sets upper window bound for rendering

    def drag(self, v, h):
        raise NotImplementedError

    def g(self, h):
        raise NotImplementedError

class Default(Rocket):

    '''
        Models the surface-to-air missile (SA-2 Guideline) described in
        http://dcsl.gatech.edu/papers/jgcd92.pdf
        https://www.mcs.anl.gov/~more/cops/bcops/rocket.html
        The equations of motion is made dimensionless by scaling and choosing
        the model parameters in terms of initial height, mass and gravity.
    '''

    DT = 0.001

    V0 = 0.0
    H0 = M0 = G0 = 1.0

    H_MAX_RENDER = 1.015

    HC = 500.0
    MC = 0.6
    VC = 620.0

    M1 = MC * M0

    thrust_to_weight_ratio = 3.5
    THRUST_MAX = thrust_to_weight_ratio * G0 * M0
    DC = 0.5 * VC * M0 / G0
    GAMMA = 1.0 / (0.5*np.sqrt(G0*H0))

    def drag(self, v, h):
        return self.DC * v * abs(v) * np.exp(-self.HC*(h-self.H0)/self.H0)

    def g(self, h):
        return self.G0 * (self.H0/h)**2

class SaturnV(Rocket):

    '''
        Throttled first stage burn of Saturn V rocket
        Specifications taken from:
        1. https://en.wikipedia.org/wiki/Saturn_V
        2. https://web.archive.org/web/20170313142729/http://www.braeunig.us/apollo/saturnV.htm
    '''

    DT = 0.5
    G = 9.81
    V0 = 0.0
    H0 = 0.0

    H_MAX_RENDER = 170e3

    # Vehicle mass + fuel: 2.97e6 kg
    # Thrust of first stage: 35.1e6 N
    M0 = 2.97e6
    THRUST_MAX = 35.1e6

    # First stage gross and dry weight: 2.29e6 kg, 130e3 kg
    # => Saturn V gross weight immediately before first stage separation
    M1 = M0 - (2.29e6-130e3) # = 810e3 kg

    # Specific pulse: 263 s
    GAMMA = 1.0/(G*263.0) # = 387e-6 kg/N/s

    D = 0.35 * 0.27 * 113.0 / 2.0

    def drag(self, v, h):
        return self.D * v * abs(v)

    def g(self, h):
        return self.G

class GoddardEnv(gym.Env):

    metadata = {
        'render.modes': ['human', 'rgb_array'],
        'video.frames_per_second': 30
    }
    
    TIMEOUT = 300
    
    def __init__(self, rocket=Default(), render_mode = "human"):
        super(GoddardEnv, self).__init__()

        self._r = rocket
        self.viewer = None
        self.number_of_steps = 0

        self.U_INDEX = 0
        self.action_space = gym.spaces.box.Box(
            low   = np.array([0.0]),
            high  = np.array([1.0]),
            shape = (1,),
            dtype = np.float32
        )

        self.V_INDEX, self.H_INDEX, self.M_INDEX = 0, 1, 2
        self.observation_space = gym.spaces.box.Box(
            low   = np.array([np.finfo(np.float32).min, 0.0, self._r.M1]),
            high  = np.array([np.finfo(np.float32).max, np.finfo(np.float32).max, self._r.M0]),
            dtype = np.float32
        )

        self.render_mode = render_mode
        self.screen = None
        self.clock = None
        self.surf = None

        self.reset()

    def extras_labels(self):
        return ['action', 'thrust', 'drag', 'gravity']

    def step(self, action):

        self.number_of_steps += 1

        v, h, m = self._state

        is_tank_empty = (m <= self._r.M1)

        a = 0.0 if is_tank_empty else action[self.U_INDEX]
        thrust = self._r.THRUST_MAX*a

        self._thrust_last = thrust

        drag = self._r.drag(v, h)
        g = self._r.g(h)

        # Forward Euler
        self._state = (
            0.0 if h==self._r.H0 and v != 0.0 else (v + self._r.DT * ((thrust-drag)/m - g)),
            max(h + self._r.DT * v, self._r.H0),
            max(m - self._r.DT * self._r.GAMMA * thrust, self._r.M1)
        )

        self._h_max = max(self._h_max, self._state[self.H_INDEX])

        terminated = bool(is_tank_empty and self._state[self.V_INDEX] < 0 and self._h_max > self._r.H0)
        truncated = bool(self.number_of_steps >= self.TIMEOUT)

        if terminated:
            reward = self._h_max - self._r.H0
        elif truncated:
            reward = -1
        else:
            reward = 0.0

        info = dict(zip(self.extras_labels(), [action[self.U_INDEX], thrust, drag, g]))

        if self.render_mode == "human":
            self.render(mode=self.render_mode)

        return self._observation(), reward, terminated, truncated, info

    def maximum_altitude(self):
        return self._h_max

    def _observation(self, normalize=True):
        # normalize
        state = np.array(self._state)
        if normalize:
            return (state - np.array([self._r.V0, self._r.H0, self._r.M1])) / np.array([0.14, 0.015, self._r.M0 - self._r.M1])
        else:
            return state

    def reset(self, seed=None):
        self._state = (self._r.V0, self._r.H0, self._r.M0)
        self._h_max = self._r.H0
        self._thrust_last = None
        self.number_of_steps = 0

        drag = self._r.drag(self._r.V0, self._r.H0)
        g = self._r.g(self._r.H0)

        info = dict(zip(self.extras_labels(), [0.0, 0.0, drag, g]))

        return self._observation(), info

    def render(self, mode='human'):
        _, h, m = self._observation(normalize=False)
        import pygame
        if self.screen is None:
            pygame.init()
            if self.render_mode == 'human':
                pygame.display.init()
                self.screen = pygame.display.set_mode((500,500))
            else:
                self.screen = self.Surface((500,500))
        if self.clock is None:
            self.clock = pygame.time.Clock()

        self.surf = pygame.Surface((500,500))
        self.surf.fill((255,255,255))
        #World coordinates
        y = self._r.H_MAX_RENDER
        y0 = self._r.H0
        GY = (y-y0)/20
        Y = y-y0+GY
        H = Y/10
        W = H/10
        #Conversion of coordinates world -> screen
        scale = 500 /Y
        self.flame_offset = W/2
        def world_to_screen(x, y_val):
            return(
                int(500/2 + x*scale),
                int((y - y_val)*scale)
            )
        
        #Draw ground
        g1 = world_to_screen(-Y/2, y0)
        g2 = world_to_screen(Y/2, y0-GY)
        pygame.draw.rect(self.surf, (77,153,77), pygame.Rect(g1[0], g1[1], g2[0]-g1[0], g2[1]-g1[1]))

        #Draw pad
        pad_w=3*W
        pad1 = world_to_screen(-pad_w,y0)
        pad2 = world_to_screen(pad_w, y0-GY/3)
        pygame.draw.rect(self.surf, (153,153,153),  pygame.Rect(pad1[0], pad1[1], pad2[0]-pad1[0], pad2[1]-pad1[1]))
        
        #Draw rocket
        rocket_top = h+H
        rocket_bottom = h
        rocket_left = -(W*3)/2
        rocket_right = (W*3)/2

        #Draw rocket nose
        nose_tip = world_to_screen(0, rocket_top)
        nose_left = world_to_screen(rocket_left, rocket_top - H*0.2)
        nose_right = world_to_screen(rocket_right, rocket_top - H*0.2)
        pygame.draw.polygon(self.surf, (50,50,50), [nose_tip, nose_left, nose_right])

        #Draw rocket body
        body_top = rocket_top - H*0.2
        body_bottom = rocket_bottom
        body_left = rocket_left
        body_right = rocket_right
        r1 = world_to_screen(body_left, body_bottom)
        r2 = world_to_screen(body_right, body_top)
        pygame.draw.rect(self.surf, (80,80,80),  pygame.Rect(r1[0], r2[1], r2[0]-r1[0], r1[1]-r2[1]))

        #Draw fuel
        fuel_height_ratio = (m - self._r.M1)/(self._r.M0 - self._r.M1)
        fuel_top = body_bottom + (body_top - body_bottom) * fuel_height_ratio
        f1 = world_to_screen(body_left, body_bottom)
        f2 = world_to_screen(body_right, fuel_top)
        pygame.draw.rect(self.surf, (204,26,36), pygame.Rect(f1[0], f2[1], f2[0]-f1[0], f1[1]-f2[1]))

        #Draw rocket fins
        fin_height = H*0.1
        fin_width = W*0.5
        fb = rocket_bottom
        #left fin
        lf1 = world_to_screen(rocket_left, fb)
        lf2 = world_to_screen(rocket_left-fin_width, fb - fin_height)
        lf3 = world_to_screen(rocket_left, fb - fin_height)
        pygame.draw.polygon(self.surf, (60,60,60), [lf1, lf2, lf3])
        #right fin
        rf1 = world_to_screen(rocket_right, fb)
        rf2 = world_to_screen(rocket_right+fin_width, fb - fin_height)
        rf3 = world_to_screen(rocket_right, fb - fin_height)
        pygame.draw.polygon(self.surf, (60,60,60), [rf1, rf2, rf3])
        
        #Draw flame
        s = 0 if self._thrust_last is None else self._thrust_last/self._r.THRUST_MAX
        flame_raduis = int(2*W*scale*s)
        if s > 0:
            flame_y = h-W /2
            fx, fy = world_to_screen(0, flame_y)
            pygame.draw.circle(self.surf, (245,128,51), (fx,fy), flame_raduis)
            pygame.draw.circle(self.surf, (245,217,89), (fx,fy), flame_raduis // 2)

        #blit
        self.screen.blit(self.surf,(0,0))
        if self.render_mode == 'human':
            pygame.event.pump()
            self.clock.tick(self.metadata.get("render_fps", 30))
            pygame.display.flip()
        else:
            return np.transpose(
                np.array(pygame.surfarray.pixels3d(self.screen)), axes=(1,0,2)
            )
        
    def close(self):
        if self.screen is not None:
            import pygame

            pygame.display.quit()
            pygame.quit()
            self.screen = None
            self.surf = None
            self.clock = None
            self.isopen = False

class GoddardDefaultEnv(GoddardEnv):

    def __init__(self):
        super(GoddardDefaultEnv, self).__init__(rocket=Default())

class GoddardSaturnEnv(GoddardEnv):

    def __init__(self):
        super(GoddardSaturnEnv, self).__init__(rocket=SaturnV())
