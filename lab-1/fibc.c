int fibonacci(int x) 
{
  int fab = 1;
  int prevFab = 0;
  int temp;
  int index;
  if (x <= 0) {
    return 0;
  }
  for (index = 0; index < x-1; ++index) {
    temp = fab;
    fab = fab + prevFab;
    prevFab = temp;
    if (fab < 0) {
      return 0;
    }
  }
  return fab;
}
