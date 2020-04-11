boolean isThereR(boolean[][] array){
  boolean result = false;
  boolean result1 = true, result2 = true, result3 = true, result4 = true;
  
  for(int i = 0; i < 9; i++){
    
    if(!array[i][5]){
      result1 = false;
    }
    if(!array[5][i]){
      result2 = false;
    }
    if(!array[i][i]){
      result3 = false;
    }
    if(!array[9-i][9-i]){
      result4 = false;
    }
    if(i == 9 && (result1 || result2 || result3 || result4)){
      result = true;
    }else{
      result = false;
    }
  }
  
  return result;
} 
