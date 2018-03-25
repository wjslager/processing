class IIR 
{
  float output, history = 0, feedback;
  
  IIR(float newFB) {
    feedback = newFB;
  }
  
  float filter(float input) {
    output = (input * (1 - feedback)) + (output * feedback);
    history = output;
    return output;
  }
}