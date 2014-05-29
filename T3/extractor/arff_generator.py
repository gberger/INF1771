import sys
import os
import extractor

script_dir = os.path.dirname(__file__)

classes = {
  '0000': 'flat_left', 
  '0001': 'flat_right', 
  '0002': 'flat_contract', 
  '0003': 'spread_left', 
  '0004': 'spread_right', 
  '0005': 'spread_contract', 
  '0006': 'v_left', 
  '0007': 'v_right', 
  '0008': 'v_contract'
}

feature_names = extractor.feature_names

# CONFIGURE THIS -- MUST BE 2 OR MORE
frames_per_example = 5

# ARFF HEADER
print "@RELATION hand"
print 
for i in range(frames_per_example):
  for feature in feature_names:
    print "@ATTRIBUTE %s_%s NUMERIC" % (feature, i)
print "@ATTRIBUTE class {%s}" % ','.join(sorted(classes.keys()))
print
print "@DATA"

# 
def frame_numbers_for_count(count):
  """Gives qty frames from a total of count"""
  result = []
  unit = float(count-1)/(frames_per_example - 1)
  for x in range(frames_per_example):
    result.append(int(x*unit))
  return result

def process_examples_folder(examples_folder):
  for class_num in classes.keys():
    class_path = os.path.join(examples_folder, class_num)
    for example in os.listdir(class_path):
      example_path = os.path.join(class_path, example)
      if os.path.isfile(example_path):
        continue
      count = int(open(os.path.join(example_path, 'count.txt')).read())
      for frame_number in frame_numbers_for_count(count):
        frame_path = os.path.join(example_path, "frame-%04d.jpg" % frame_number)
        frame_features = extractor.extract(frame_path)
        for feature in feature_names:
          sys.stdout.write('%.15f,' % frame_features[feature])
      sys.stdout.write('%s\n' % class_num)    


for n in range(4, 5):
  folder = os.path.join(script_dir, '../examples/Set%d/' % n)
  process_examples_folder(folder)
