Map<int, String> monthIntToString = {
  1: "January",
  2: "February",
  3: "March",
  4: "April",
  5: "May",
  6: "June",
  7: "July",
  8: "August",
  9: "September",
  10: "October",
  11: "November",
  12: "December",
};

Map<int, int> monthPatternIntToString = { //each month and its days
  1: 31,
  2: 29,
  3: 31,
  4: 30,
  5: 31,
  6: 30,
  7: 31,
  8: 31,
  9: 30,
  10: 31,
  11: 30,
  12: 31,
}; 
  
String codeToDate(String code) //Adds st, nd, rd or th and the month to date (5_1 -> 1st May)
{
  if(code.split("_")[1].length == 1)
  {
    if(code.split("_")[1] == "1") 
    {
      return "${code.split("_")[1]}st ${monthIntToString[int.parse(code.split("_")[0])]}";
    } 
    else if(code.split("_")[1] == "2") 
    {
      return "${code.split("_")[1]}nd ${monthIntToString[int.parse(code.split("_")[0])]}";
    } 
    else if(code.split("_")[1] == "3") 
    {
      return "${code.split("_")[1]}rd ${monthIntToString[int.parse(code.split("_")[0])]}";
    } 
    else 
    {
      return "${code.split("_")[1]}th ${monthIntToString[int.parse(code.split("_")[0])]}";
    }
  }
  else
  {
    if(code.split("_")[1][1] == "1") 
    {
      return "${code.split("_")[1]}st ${monthIntToString[int.parse(code.split("_")[0])]}";
    } 
    else if(code.split("_")[1][1] == "2") 
    {
      return "${code.split("_")[1]}nd ${monthIntToString[int.parse(code.split("_")[0])]}";
    } 
    else if(code.split("_")[1][1] == "3") 
    {
      return "${code.split("_")[1]}rd ${monthIntToString[int.parse(code.split("_")[0])]}";
    } 
    else 
    {
      return "${code.split("_")[1]}th ${monthIntToString[int.parse(code.split("_")[0])]}";
    }

  }
}