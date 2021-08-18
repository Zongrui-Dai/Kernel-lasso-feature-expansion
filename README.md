# Kernel-lasso-feature-expansion
## About the program
This program manily used to amplify the existed dimension of dataset by creating new features. The main process can be divided into two parts:<br>
1. Amplify the existed feature by Gauss function<br>
2. Remove the abundant feature by lasso method<br>

This method may improve the accuracy of some models when making regression or classification. It's one small attempt, which may need further improvement.<br>

<div align=center>
<img src="https://github.com/Zongrui-Dai/Kernel-lasso-feature-expansion/blob/main/fig/lasso.jpeg">
</div>

This is the output figure which is made by 'glmnet' pakcage. The two vertical lines represent two different feature numbers. (lambda_min = 8, lambda_1se = 7).Detailed information can be viewed from ‘glmnet’ package. 

## Function
1.[Kernel_lasso.R](https://github.com/Zongrui-Dai/Kernel-lasso-feature-expansion/blob/main/R/Kernel_lasso.R)<br>
It is used to construct the kernel-lasso structure and output the final features. The ‘kernel_lasso_expansion’ will return 5 results contains in one list:<br>
```R
List of 5
 $ original     :'data.frame':	182 obs. of  3 variables:     ##The original dataset
 $ expansion    :'data.frame':	182 obs. of  9 variables:     ##The amplified dataset
 $ final_feature: chr [1:8] "event" "dist" "1 2" "1 3" ...    ##The name of the final feature
 $ final_data   :'data.frame':	182 obs. of  8 variables:     ##The dataset of the final feature
 $ lasso        :List of 12                                   ##The result from the cv.glmnet()
```
2.[Standardization.R](https://github.com/Zongrui-Dai/Kernel-lasso-feature-expansion/blob/main/R/Standardization.R)<br>
This function is used to calculate the Z-score and max-min-scale of the dataset. The input dataset should be ‘data.frame’

## Future work
I will keep updating the program if any improvement is needed. This method still needs further testing to prove whether it can improve the ability of certain<br>
models or which model will gain the most benefits. <br>

## Tips
1.The package has been updated to CRAN. If the test is passed, I will put up a link here.
```
Z. Dai, J. Li, T. Gong, C. Wang (2021), Kernel_lasso feature expansion method: boosting the prediction ability of machine learning in heart attack,” 2021 IEEE.
```
