#' @title max_min_scale
#' @name max_min_scale
#' @description max_min_scale is used to calculate the standardization value of data.The formula is (x-min(x))/(max(x)-min(x)). It can compress the data into the (0,1).
#' @param data Your input data, which can be numerci or data.frame
#' @param dataframe Wether the data is dataframe. The default is False(numeric)
#' @keywords max_min_scale
#' @export
#' @examples 
#' ##For the numeric data
#' data(iris)
#' w<-max_min_scale(iris[,1])
#' print(w)
#' 
#' ##For the data.frame data
#' w1<-max_min_scale(iris[,-5],dataframe=T)
#' print(w1)
max_min_scale<-function(data,dataframe=F){
  if(dataframe==F){
    data<-(data-min(data))/(max(data)-min(data))
  }else{
    for(i in 1:length(data)){
      scale<-(data[,i]-min(data[,i]))/(max(data[,i])-min(data[,i]))
      data[,i]<-scale
    }
    return(data)
  }
}

#' @title Z_score
#' @name Z_score
#' @description Z-score method is used to calculate the standardization value of data.The formula is (x-mean(x))/var(x). It can compress the data into the (0,1).
#' @param data Your input data, which can be numerci or data.frame
#' @param dataframe Wether the data is dataframe. The default is False(numeric)
#' @keywords Z_score
#' @export
#' @examples 
#' ##For the numeric data
#' data(iris)
#' w<-Z_score(iris[,1])
#' print(w)
#' 
#' ##For the data.frame data
#' w1<-Z_score(iris[,-5],dataframe=T)
#' print(w1)
Z_score<-function(data,dataframe=F){
  if(dataframe==F){
    data<-(data-mean(data))/var(data)
  }else{
    for(i in 1:length(data)){
      scale<-(data[,i]-mean(data[,i]))/var(data[,i])
      data[,i]<-scale
    }
    return(data)
  }
}



