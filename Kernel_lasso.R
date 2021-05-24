#' @title kernel_lasso_expansion
#' @name kernel_lasso_expansion
#'
#' @description Kernel_lasso is one feature selection method, which combines the feature expansion and lasso regression together. Kernel function will increase the dimensions of the existed data and then reduce the features by lasso
#' 
#' @param x Your input features, which can have to be data.frame with at least two variables.
#' @param y The dependent variable
#' @param sigma The hyperparameter of RBF kernel function, which indicates the width.
#' @param dataframe Wether the data is dataframe. The default is TURE
#' @param standard Using 'max_min_scale' or 'Z_score' method to standardize the data. NULL means no standardization
#' @keywords kernel_lasso_expansion
#' @export
#' @examples 
#' ##Regression (MSE)
#' data(attenu)
#' result<-kernel_lasso_expansion(x=attenu[,-c(3,5)],y=attenu[,5],
#' standard = 'max_min',sigma=0.01,control = lasso.control(nfolds=3,type.measure = 'mse'))
#' summary(lasso)
#' 
#' #Plot the lasso
#' plot(result$lasso)
#' 
#' #Result
#' result$original ##The original feature space
#' result$expansion  ##The feature space after expansion
#' result$final_feature  ##The name of the final feature
#' result$final_data  ##The dataframe of final feature
#' 

library('glmnet')
kernel_lasso_expansion<-function(x,y,sigma=0.5,standard='max_min',dataframe=T,
                       control=lasso.control()){
  if(standard=='max_min'){
    data<-max_min_scale(x,dataframe)
  }
  else if(standard=='Z_score'){
    data<-Z_score(x,dataframe)
  }
  else if(standard==NULL){
    data<-x
  }
  coln<-colnames(data)
  col<-length(data)
  id=0
  for(i in 1:col){
    for(j in 1:col){
      if(i == j){
      }else{
        w<-gauss(data[,i],data[,j],sigma)
        id=id+1
        data<-cbind(data,w)
        coln<-c(coln,paste(i,j))
      }
    }
  }
  colnames(data)<-coln
  ## Lasso reduction
  nf<-as.numeric(control[['nfolds']])
  tr<-as.numeric(control[['trace']])
  type<-control[['type.measure']]
  lasso<-cv.glmnet(as.matrix(data),as.matrix(y),
                   nfolds = nf,trace.it = tr,type.measure = type)
  plot(lasso)
  param<-coef(lasso,s='lambda.min')
  param<-as.data.frame(as.matrix(param))
  param$feature<-rownames(param)
  param_e1<-param[param$'1'!= 0,]
  feature<-rownames(param_e1[-1])[-1]
  
  result<-list(original=x,expansion=data,final_feature=feature,final_data=data[,feature],lasso=lasso)
  return(result)
}

#' @title lasso.control
#' @name lasso.control
#' @description Kernel_lasso is one feature selection method, which combines the feature expansion and lasso regression together. Kernel function will increase the dimensions of the existed data and then reduce the features by lasso
#' 
#' @param x Your input features, which can have to be data.frame with at least two variables.
#' @param y The dependent variable
#' @param sigma The hyperparameter of RBF kernel function, which indicates the width.
#' @param dataframe Wether the data is dataframe. The default is TURE
#' @param standard Using 'max_min_scale' or 'Z_score' method to standardize the data. NULL means no standardization
#' @keywords lasso.control
#' @export
#' @examples 
#' ##10-fold Cross-validation with MSE as loss function
#' c<-lasso.control(nfolds=10,type.measure='mse')

lasso.control<-function(nfolds=10,trace.it=1,type.measure='auc'){
  control<-c(nfolds=nfolds,trace=trace.it,type.measure=type.measure)
  return(control)
}


#' @title gauss
#' @name gauss
#' @description gauss function 
#' @param d1 vector1
#' @param d2 vector2
#' @param sigma The hyperparameter of RBF kernel function, which indicates the width.
#' @keywords Gauss function
#' @export
#' @examples 
#' ##
#' data(iris)
#' w<-gauss(iris[,1],iris[,2])
#' print(w)


gauss<-function(d1,d2,sigma=0.5){
  c<-exp(-(d1-d2)^2)/(2*sigma^2)
  return(c)
}