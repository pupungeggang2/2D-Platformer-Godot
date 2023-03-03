extends Node

func point_inside_rect_array(x, y, rect):
	return x > rect[0] and x < rect[0] + rect[2] and y > rect[1] and y < rect[1] + rect[3]
	
func distance_between_two_point(point_1, point_2):
	return sqrt(pow(point_1.x - point_2.x, 2) + pow(point_1.y - point_2.y, 2))
