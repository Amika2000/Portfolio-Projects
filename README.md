## Predicting Carbon Emissions using Python
The first project focuses on predicting carbon emissions in specific regions of South Africa, utilising data collected from 2019 to 2022. This project was undertaken as part of the Ernst & Young Carbon Prediction Hackathon, and its code has been included in my portfolio with permission under a Creative Commons License. The code was developed and executed using Google Colab, while a machine learning model was employed for making predictions. The data underwent a thorough cleaning process, addressing missing values and implementing feature engineering techniques to enhance its quality and suitability for analysis. To evaluate the model's performance, the Root Mean Squared Error (RMSE) was calculated for two different types of models: a Random Forest model and a Boosting model. The model that demonstrated a lower RMSE was selected for generating the final predictions.

Please note that the provided code involves downloading the 'Train,' 'Test,' and 'SampleSubmission' files from "https://drive.google.com/drive/folders/1BSJPaNzaxRp6VFJvOxwcjdMWnsppsvq2?usp=drive_link"and mounting them onto your drive; if the path to this data differs from DATA_PATH of the above Colab session, the path will need to be changed with the link for the new path.

## Covid 19 Summary in Tableau
The second project entails creating a Tableau dashboard that summarises data from the 'covid_19_data' dataset. The dashboard has been recreated based on the works of Databoard Analytics (https://www.youtube.com/watch?v=sX5iupivFN8) to showcase my skills. It provides an overview of the total confirmed cases and recovered cases for different countries and continents, as well as presenting the total death count. It should be noted that the summary created in Tableau may overestimate the actual total counts and is intended for skill demonstration purposes rather than providing an accurate representation of the data collected between 2021 and 2022.

## Spatial Analysis of Sea Surface Temperatures using R
The third project is part of my Master's coursework and it involves analysing a dataset of sea surface temperature spanning over a month in the Grand Banks region off the East Coast of North America. The data is interpolated onto a grid with a resolution of 0.5° in both the East and North directions, assuming a flat Earth. The investigation is conducted using R programming, with the spatial analysis performed using the 'geoR' statistics package. The analysis begins by plotting the derived data and assessing its isotropy. Next, suitable spatial models are chosen to fit the dataset, and the model parameters are estimated using the Maximum Likelihood Estimation method. The model is then validated, and the results are plotted.

Please note that the 'read.csv' code may need to be adjusted according to the path of the downloaded "GrandBanks_Dec_1997" dataset.




