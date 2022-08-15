proc PutLine*(args:seq[string]):void = 
  for arg in args:
    stdout.write(arg);
  stdout.write("\n");