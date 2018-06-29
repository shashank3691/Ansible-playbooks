import os
if os.path.exists("/home/ec2-user/file1.txt"):
  os.remove("/home/ec2-user/file1.txt")
else:
  print("The file does not exists")

print("Hello,world!")
