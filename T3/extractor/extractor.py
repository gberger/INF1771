import os
from operator import itemgetter
import cv2
import cv2.cv
import numpy as np

lower = np.array([0, 30, 60])
upper = np.array([50, 150, 255])

def imread_bw(filename):
  """Takes a filename for an image, loads it and turns into BW

  Uses HSV segmentation to capture skin color, but not light"""
  if not os.path.isfile(filename):
    raise ValueError("%s is not a file!" % filename)
  img = cv2.imread(filename)
  img_hsv = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)
  img_bw = cv2.inRange(img_hsv, lower, upper)

  return img_bw

def morph(image):
  """Removes noise"""
  kernel = cv2.cv.Set(cv2.cv.CreateMat(3, 3, cv2.CV_8UC1), 255)
  image = cv2.morphologyEx(image, cv2.MORPH_DILATE, kernel); 
  image = cv2.morphologyEx(image, cv2.MORPH_DILATE, kernel);
  image = cv2.morphologyEx(image, cv2.MORPH_ERODE, kernel);
  image = cv2.morphologyEx(image, cv2.MORPH_ERODE, kernel);
  return image

def extract_features(image):
  """Returns a dict of featues"""
  features = dict()

  # Find the contour with max area
  contours, hierarchy = cv2.findContours(image, cv2.cv.CV_RETR_LIST, cv2.cv.CV_CHAIN_APPROX_NONE)
  ca = [(c, cv2.contourArea(c)) for c in contours]
  contour = max(ca, key=itemgetter(1))[0]

  # Preliminary  
  hull = cv2.convexHull(contour)
  defects = cv2.convexityDefects(contour, cv2.convexHull(contour, returnPoints=False))
  rect = cv2.minAreaRect(contour)
  ellipse = cv2.fitEllipse(contour)
  moments = cv2.moments(contour, True)
  huMoments = cv2.HuMoments(moments)

  # Features
  features['area'] = cv2.contourArea(contour)
  features['perimeter'] = cv2.arcLength(contour, True)
  features['convex_hull_area'] = cv2.contourArea(hull)
  features['solidity'] = features['area']/features['convex_hull_area']
  features['rect_center_x'] = rect[0][0]
  features['rect_center_y'] = rect[0][1]
  features['rect_width']  = rect[1][0]
  features['rect_height'] = rect[1][1]
  features['rect_angle'] = rect[2]
  features['rect_aspect_ratio'] = float(rect[1][0])/rect[1][1]
  features['ellipse_center_x'] = ellipse[0][0]
  features['ellipse_center_y'] = ellipse[0][1]
  features['ellipse_major_axis'] = ellipse[1][0]
  features['ellipse_minor_axis'] = ellipse[1][1]
  features['ellipse_angle'] = ellipse[2]
  features['farthest_convex_defect'] = max([d[0][3] for d in defects])
  features['hu_moment_1'] = huMoments[0][0]
  features['hu_moment_2'] = huMoments[1][0]
  features['hu_moment_3'] = huMoments[2][0]
  features['hu_moment_4'] = huMoments[3][0]
  features['hu_moment_5'] = huMoments[4][0]
  features['hu_moment_6'] = huMoments[5][0]
  features['hu_moment_7'] = huMoments[6][0]

  return features

def extract(filename):
  img = imread_bw(filename)
  img = morph(img)
  return extract_features(img)

feature_names = sorted([
  'area',
  'perimeter',
  'convex_hull_area',
  'solidity',
  'rect_center_x',
  'rect_center_y',
  'rect_width',
  'rect_height',
  'rect_angle',
  'rect_aspect_ratio',
  'ellipse_center_x',
  'ellipse_center_y',
  'ellipse_major_axis',
  'ellipse_minor_axis',
  'ellipse_angle',
  'farthest_convex_defect',
  'hu_moment_1',
  'hu_moment_2',
  'hu_moment_3',
  'hu_moment_4',
  'hu_moment_5',
  'hu_moment_6',
  'hu_moment_7'
])