class Easing
{
  float target, distance, output, easing;

  Easing(float easing)
  {
    this.easing = easing;
  }

  float ease(float input)
  {
    if (output != input) {
      target = input;
      distance = target - output;
      output += distance * easing;
      return output;
    }
    return input;
  }

  void setEase(float easing) {
    this.easing = easing;
  }
}