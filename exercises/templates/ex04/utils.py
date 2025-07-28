def build_uturn_course(course_dim, inner_wall_dim):
    """
    Build a race track for the u-turn street scenario.
    Start and finish line are placed in the center top and bottom respectively. The course dimension specifications
    do not consider a bounding wall around the track, which is inserted additionally. 

    """
    track = []
    wall_up_bound = course_dim[0]//2 - inner_wall_dim[0] // 2
    wall_bottom_bound = course_dim[0]//2 + inner_wall_dim[0]//2
    street_width = course_dim[1]//2 - inner_wall_dim[1]//2
    # construct course line by line
    for i in range(course_dim[0]):
        if i < wall_up_bound:
            half_street_len = course_dim[1]//2 - 1
            track_row = 'W'*(half_street_len//2+1) + 'W-' + 'o'*(half_street_len-1+half_street_len//2)
        elif  wall_up_bound <= i < wall_bottom_bound:
            track_row = 'W'*street_width + 'W'*inner_wall_dim[1] + 'o'*street_width
        else:
            track_row = 'W'*(half_street_len//2+1) + 'W+' + 'o'*(half_street_len-1+half_street_len//2)
        track.append(track_row)
    # add boundary
    track = ['W'*course_dim[1]] + track + ['W'*course_dim[1]]
    track = ['W'+s+'W' for s in track]
    return track


def build_rect_course(course_dim, inner_wall_dim):
    """
    Build a race track given specifications for the outer cyclic street and inner wall dimensions.
    Start and finish line should be placed in the center top. The course dimension specifications
    do not consider a bounding wall around the track, which must be inserted additionally.
    
    Args:
        course_dim: 2-tuple, (y-dim, x-dim): The size of the track without outer walls.
        inner_wall_dim: 2-tuple (y-dim, x-dim): The size of the inner wall
    
    """
    track = []
    wall_up_bound = course_dim[0]//2 - inner_wall_dim[0] // 2
    wall_bottom_bound = course_dim[0]//2 + inner_wall_dim[0]//2
    street_width = course_dim[1]//2 - inner_wall_dim[1]//2
    # construct course line by line
    for i in range(course_dim[0]):
        if i < wall_up_bound:
            half_street_len = course_dim[1]//2 - 1
            track_row = 'o'*half_street_len + '+W-' + 'o'*(half_street_len-1)
        elif  wall_up_bound <= i < wall_bottom_bound:
            track_row = 'o'*street_width + 'W'*inner_wall_dim[1] + 'o'*street_width
        else:
            track_row = 'o'*course_dim[1]
        track.append(track_row)
    # add boundary
    track = ['W'*course_dim[1]] + track + ['W'*course_dim[1]]
    track = ['W'+s+'W' for s in track]
    return track