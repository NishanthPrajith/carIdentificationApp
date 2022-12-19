<div align="center">
	<h1>CarMe</h1>
</div>

<br/>
<div align="center" style="display:grid; 
            justify-content: center;
            padding:15px 0 30px 0">
    <div>
        <img src = "https://i.imgur.com/cqYkHAR.png" />
    </div>
</div>
<br/>

CarMe is a car detection app that helps users discover the model of a car that they are interested in. This is done through the use of an image classification model. CarMe can detect over 23 unique car models ([full list of car models](#Full-list-of-23-classes-of-cars)). Besides classifying cars, CarMe also allows users to browse all available cars, search for a specific car by name or model, and save any cars to their favorites list. Our hope is that this app would allows the users to identify unique/classic cars. Cars that many people do not see on a daily basis.


## Design

### Software Design

The software consists of 3 main components: **PyTorch model, Firebase, and Flutter**.

We used **Flutter** to build the front end of the mobile app which allows users to take a picture of a car and display the prediction by running it through the Pytorch model. This app is what the users will use to iteract with our model.

We used **Firebase** for the backend of the app. Specifically, we used Firebase Authentication to support user sign-up, sign-in, and sign-out. In addition we made use of Firebase Cloud Firestore to store car related information such as images of the car, max speed of the car, etc. We also used Firestore to store information about user's favorite cars so they have that information readily available for them on their dashboard.

Finally, the **PyTorch model** is the core of the entire software. It is responsible for classification of the taken image and providing the prediction to flutter and firebase to then get information about the car.

The following diagram shows the data flow in the software.
<div style="display:grid; 
            justify-content: center;
            padding:15px 0 30px 0">
    <div>
        <img src = "https://i.imgur.com/2HQdgjq.png" />
    </div>
</div>

### User Interface Design
At a granular level, the user interacts with the app through the use of the camera. Once, the user is loaded into the app they will be greeted to the camera page which is also the main page of the app *(shown below)*.

<br/>
<div align="center" style="display:grid; 
            justify-content: center;
            padding:15px 0 30px 0">
    <img src = "https://i.imgur.com/CJiaNpA.png" />
</div>
<br/>

Once, on this screen the user has the following options they can either click on the big white button to take a picture and have the ML model classify the image on the screen or navigate to the other pages using the navigation bar on the bottom. 

If they choose to click the white button, the app within a few seconds will take a picture using the device's camera and then go into the loading screen *(shown below)* to wait for the model to provide the prediction on the taken image.

<br/>
<div align="center" style="display:grid; 
            justify-content: center;
            padding:15px 0 30px 0">
	<img src = "https://i.imgur.com/tS6vPhm.png" />
</div>
<br/>

Once, the model provides the prediction to the app the user will be greeted with the following screen.

<br/>
<div align="center" style="display:grid; 
            justify-content: center;
            padding:15px 0 30px 0">
    <img src = "https://i.imgur.com/mtHmVo6.png" />
</div>
<br/>

Here, the user can see the prediction of the model on the bottom in the slide up drawer. To view more information about the predicted car class the user can slide up on the drawer and see more detailed information about the car *(shown below)*. Here the user is free to scroll down and read more about the predicted car class.

<br/>
<div align="center"style="display:grid; 
            justify-content: center;
            padding:15px 0 30px 0">
    <img src = "https://i.imgur.com/Skl4nhe.png" />
</div>
<br/>

Once, the user is done scrolling they can slide down on the drawer from the top to go back to the screen from before. And slide down again on the drawer to go back to the camera for classifying another picture.

Now, if the user selected to go the `account` option from the navigation bar they will be greeted with `sign in` page *(shown below)*. If the user does not have an account they can click on the blue `Sign Up` button on the bottom of the page and have themselves be taken to the sign up page *(also shown below)*.

<br/>
<div align="center" style="display:grid; 
            justify-content: center;
            padding:15px 0 30px 0">
    <div>
        <img style="margin-right: 35px" src = "https://i.imgur.com/3jzLDkF.png" />
	    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <img style="margin-left: 35px" src = "https://i.imgur.com/8UUtTzy.png" />
    </div>
</div>
<br/>

Once, the user creates an account or logins in with their existing account they will be greeted with the main user dashboard. Here they can choose to sign out using the button on the top right corner or explore their favorite/saved cars by clicking on the individual item in the list. 

Clicking on the `Sign Out` button will take them back to the login page from before. And if they click on one of the saved cars from the list, it will open a new page where they will be able to get detailed information about the car they just selected.

*We have included the dashboard with and without a favorite cars list.*

<br/>
<div align="center" style="display:grid; 
            justify-content: center;
            padding:15px 0 30px 0">
    <div>
        <img style="margin-right: 35px" src = "https://i.imgur.com/h3K5FDR.png" />
	    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <img style="margin-left: 35px" src = "https://i.imgur.com/6FcjpvS.png" />
    </div>
</div>
<br/>

Last but not least the user can select to go to the search page from the navigation bar *(shown below)*.

<br/>
<div align="center" style="display:grid; 
            justify-content: center;
            padding:15px 0 30px 0">
    <div>
        <img src = "https://i.imgur.com/78igXEX.png" />
    </div>
</div>
<br/>

Here, they are free to browse the different car classes the current model can predict or use the search bar to search for a specific car using keywords as *shown below*.

<br/>
<div align="center" style="display:grid; 
            justify-content: center;
            padding:15px 0 30px 0">
    <div>
        <img src = "https://i.imgur.com/CXVTVR3.png" />
    </div>
</div>
<br/>

If they choose to view more detailed information about a car they can click on the car tile and be taken to the details page *shown below*. Here the user can scroll down to view more information or click on the arrow at the top left hand corner to go back to the search page.

<br/>
<div align="center" style="display:grid; 
            justify-content: center;
            padding:15px 0 30px 0">
    <div>
        <img src = "https://i.imgur.com/hdJYzRF.png" />
    </div>
</div>
<br/>

Once, the user signs into their respective account, the above page will also have a heart on the right hand corner which the user can click on to add the car to their favorites list.

*If the heart is filled it means it is saved else it is not.*

<br/>
<div align="center" style="display:grid; 
            justify-content: center;
            padding:15px 0 30px 0">
    <div>
        <img style="margin-right: 35px" src = "https://i.imgur.com/jO0CDVI.png" />
	    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <img style="margin-left: 35px" src = "https://i.imgur.com/e92kCcO.png" />
    </div>
</div>
<br/>

There you go, now you have a good understanding of how to use the app and how a user interacts with the app. 

**Enjoy and have fun classifying cars!**

<br/>

## Code organization
> *NOTE : You will not be able to run the app until you connect it to firebase firestore. The file generated by the connection to firestore is not included in the repository due to security concerns.*
- `Front-end & App Code`
  - `AppFiles/lib/`
      - `main.dart` : The main flutter file which is the root of all the other pages of the app
      - `searchPage.dart` : The main code for the search page of the app
      - `cameraPage.dart` : The main code for the camera page of the app
      - `classifier.dart` : This is the file that handles the classification of the image taken by the camera. It loads the models along with the labels and uses the `PyTorch_Mobile` library for classification.
  - `AppFiles/lib/comps`
      - `detailsPage.dart` : The code for the page which lists detailed information of a car
  - `AppFiles/lib/Auth`
      - `SigninPage.dart` : Sign In page flutter code of the app
      - `signuppage.dart` : Sign Up page flutter code of the app
      - `accountPage.dart` : The main code for the account page of the app
      - `UserDataComp.dart` : Flutter code for the page the user sees after the user logins into their respective account (*replaces the account page*)
- `Model Training Code`
    - `Pre-Processing-Code/`
         - `car_list.csv` : *.csv* file which has a list of the car classes we the ML model can predict
         - `TrimsData.csv` : *.csv* file which has information regarding the different car classes the current model classifies
      - `Pre-Processing_V1.ipynb` : Jupyter notebook which combines the different datasets together and create the final dataset which is used for training of the models
      - `CarImage_PreProcessing.ipynb` : Jupyter notebook which include the OpenCV code that takes a particular image and splits it into its left and right half
  - `Model-Notebook-Code/Training/`
      - **Model Training Code**
  - `Model-Notebook-Code/Testing/`
      - `Model_Testing_code.ipynb` : This is the testing notebook for the any model other than an ensemble model. (*Ex : DenseNet, ....*)
      - `Ensemble_Model_Testing_code.ipynb` : This is the testing notebook for the ensemble model. 
     
<br/>

## Requirements
- To run the flutter app you need to have flutter installed. Please refer to the [documentation](https://docs.flutter.dev/get-started/install) for this information.
- Training the model does require the use of a GPU otherwise the training time could be over 8 hours. We used [Kaggle](https://www.kaggle.com) to train our models and used [Google Colaboratory](https://colab.research.google.com) for testing the model. With Kaggle it is possible to schedule a notebook run that will run the notebook in the background without user input.
- Lastly, for the app to work you would need to connect the app to your respective firestore account. The information for which could be found [here](https://firebase.google.com/docs/flutter/setup?platform=ios).

<br/>

## App Compatibility Support
Currently, the app only works on Android devices. So to run the app one would require either a physical android device or an android simulator.

<br/>

## Machine Learning Dataset Description
### Training Dataset
Our training dataset can be found here in this [OneDrive link](https://ccnymailcuny-my.sharepoint.com/:u:/g/personal/nprajit000_citymail_cuny_edu/EbQNr7_DIz9FqzamL3oMeqQBwouzHvIVHDBh0UrCgep0PQ?e=DnG5Vz) and includes about 46,000 images of 23 different car classes *(listed below)*. 

#### Full list of 23 classes of cars

```
toyota sienna
jeep cherokee
ford focus SE
honda civic
honda accord
ford mustang GT
chevrolet camaro SS
chevrolet corvette
toyota rav4
toyota camry
toyota corolla
mercedes-benz g-class
mercedes-benz s-class sedan
mercedes-benz g-class amg
bmw 3 series sedan
bmw 5 series sedan
bmw m3
bmw x3
porsche	911 Turbo
tesla model X
tesla model Y
tesla model 3
tesla model S
```
This dataset was created by merging the *Stanford cars dataset*, *Images downloaded from Google*, *DVM Dataset*, and *Car Connection Picture Dataset* (found in [Resources](##Resources)). Each of these datasets included images of several different car classes but we had to filter them out for our specific car classes using the `Pre-Processing_V1.ipynb` notebook. 

The classes we selected combined a mix of common cars as well as unique cars such as the `Ford Mustang GT` which has a unique body shape. The year of the cars are excluded since, many cars like the `Honda Accord` do not change much over the years other than in performance. But the general body shape remains the same, hence, there is no way for any ML model to identify what year the car is from unless the model sees under the hood. But if you were to adapt this model for a more unique cars whose body shape changes over the years you can add the years. It is entirely up to you.


#### Create your own dataset
If you wish to create your own dataset, we will explain the process here.

Firstly, you will need to download the necessary datasets from [Resources](##Resources). We will not explain how to download images from Google as it is entirely up to and if you wish to use the code we used for our purpose you are free to do so. They have a well written documentation which outlines how to properly do it with the python code.

Once, you gathered all the datasets you will now need to open the `car_list.csv` file and then replace the **Make** and **Model** with your own list.

Then, from there it is simple as running the `Pre-Processing_V1.ipynb` and letting the python code take care of the rest.

In the end you should have a folder called `final_dataset` in your local environment which would be your new custom training dataset.

**Remember to check the final dataset to ensure all of your classes are in the dataset!**

### Testing Dataset
Our testing dataset is uploaded into this [OneDrive link](https://ccnymailcuny-my.sharepoint.com/:u:/g/personal/nprajit000_citymail_cuny_edu/EUuuTUfAJINOotZ9mbhSdOoBVPIWfnKJYuCM6sQZWNjEJA?e=CnYoC3) and it includes about 300 images. This dataset includes some images we took using our phones as well as images downloaded from the web using the [Baidu](https://www.baidu.com/) search engine. We did this specifically to ensure the validity of the dataset and prevent the chances of any images being part of both the testing and training dataset.

Each image in this dataset is a named in a specific way to get detailed insights about the model when testing. So, if you add more images please adhere to this standard which we will explain here.

#### Image Naming Standard

Each image is named in the following format `a_b_c_1.jpg`. Here `a, b and c` (*You do not need all a, b, and c*) is any value that is part of the list (shown below) and is seperated with `_`.
```
far, back-side, back, front-side, front, side
```
The each of these values represent what the image shows
- `far` means that the car in the image is far meaning you can see the entire car body
- `back-side` means that you can see the back and side of the car in the image
- `back` means that you can only see the back of the car in the image
- `front` means that you can only see the front of the car in the image
- `front-side` means that you can see the front and side of the car in the image.

**NOTE :** You are in no way limited to the above values. You can add more values such as `logo` to represent if the logo of the car brand is shown in the image. But you need to remember to seperate them with `_` for the testing code to properly identify the different categories the image falls under and give you details insights.

<br/>

## Machine Learning Model Design and Experimental Performance

After, we realized DenseNet161 accuracy was not improving after some experiments we decided it was time to try a different approach to improvement. We decided that we need to test various different parameters and see how they do to get a sense of how well each of them could do. These different strategies we attempted were :
1. [Different pre-trained models](#Different-pre-trained-models)
2. [Change the hyperparameters](#Change-the-hyperparameters)
3. [Freezing the layers](#Freezing-the-layers)
4. [Image Augmentation](#Image-Augmentation)
5. [Add more classes to the training dataset](#Add-more-classes-to-the-training-dataset)
6. [Change the fully connect layer](#Change-the-fully-connect-layer)
7. [Ensemble Learning](#Ensemble-Learning)

<br/>

### Different pre-trained models

One of the first things we tried was different pre-trained models like ResNet, RegNet_y_3_2gf, RegNet_y_8gf,. Inception, MobileNet_v3_large, and GoogleNet in place of DenseNet which we have been using. We wanted to see if using a different pre-trained model will produce a better result. This could possibly mean we can go down a different road and see how to improve the accuracy and build a better model. After training the each of the pre-trained model and testing them we got the following testing accuracy result.

```
MobileNet : 56.17%
Inception V3 : 62.33%
GoogLeNet : 59.67%
ResNet50 : 58.56%
RegNet_y_8gf : 64.04%
RegNet_y_3_2gf : 64.72%
```

After looking at the each of testing accuracy results of the pre-trained models we noticed that both RegNet_y_8gf and RegNet_y_3_3gf did outperform the DenseNet161 by over 2%. This provided the first indication that maybe DenseNet was not a good choice and RegNet models could prove to be more better at this type of classification.

Once, we did this testing on the pretrained models we noticed two things which significantly changed our understand of CNN and also how we approach testing from here on out. Both of things we noticed had to do with transformations (pre-processing on the images) during training. We will explain these observations below.

#### Addition of CenterCrop
While traing the pre-trained model, we stuck with the transformation rules provided in the pytorch documentation which most of time was
```
transforms.Resize(256)
transforms.CenterCrop(224)
```
But, when testing the models accuracy on the test dataset we only added the ``Resize`` transformation. But, we decided to add the ``CenterCrop`` transformation to see what would happend. And interestingly we noticed our results increased. In fact, it increased the accuracy of the RegNet models by 2% to the following.

```
RegNet_y_8gf : 66.44%
RegNet_y_3_2gf : 66.10%
```

Unfortunately, although the addition of the ``CenterCrop`` transformation did improve the accuracy. There was no way to do this in flutter since, the 'pytorch_mobile' only allowed for `Resize` transformation and not any kind of `CenterCrop` transformation.


#### Variable Image Size?
The second thing we noticed was that we were not limited on the testing image input size. What this means is that lets say we trained a model using the following transformation.
```
transforms.Resize(256)
```
During testing, most people would also use the same transformation with a value of 256 but, we realized that we were not limited to this size during testing. So even if we did a `Resize` of `256` during training we can use a different value during testing and the model still works. We noticed that the results were not consistent nor did they have any pattern. Something the accuracy would jump and other times it would go down significantly. There was no discernible pattern. This was a baffling observation as we did not really understand why this is happening. Hence, this section is aptly named with a question mark.

Just a quick side note about PyTorch Transforms Documentation.
<div style="text-align: center">
    <p><strong>torchvision.transforms.Resize(size, ..)</strong></p>
</div>

In this **size** can be either *sequence* or *int*.  If the size is a sequence like (h, w), output side will be matched to this. If size is an int, smaller edge of the image will be matched to this number. i.e, if height > width, then image will be rescaled to `(size * (height / width), size)`.

<br/>

### Change the hyperparameters

<br/>
<div align="center" style="display: grid; margin-top: 5%; margin-bottom:2%; justify-content: center">
	
| DenseNet161| Testing Accuracy| Training Accuracy|
|:------------:|:----------------:|:------------:|
|**10 Epochs** | 63.1%|    99%    |
|**15 Epochs** |      63.4%    |     99.03%      |
|**20 Epochs** |     64%    |   99.1%      |
|**10 Epochs lr 0.002**|  64%    |     99.1%     |
|**20 Epochs lr 0.002** |   64%  |   99.1%     |
</div>
<br/>

For the pretrained DenseNet161 Model we have tested epoch values of 10, 15, 20, 25, 30 but have reached the best accuracy when modifying the number of epochs to 20 epochs. After the epoch value of 20 we did have any increase in testing accuracy, it just led to a longer training time, due to this the table only includes up to value of epoch 20. 

We also tested different learning rates for the DenseNet161 model, we have found that experimenting with these learning rates has given us the same best model accuracy, but needs less epochs to reach that accuracy. We can see that the learning rate of .002 for 10 and 20 epochs has given us the same results, since the model reaches best accuracy by epoch 7. 

We can conclude when it comes to testing learning rate vs epoch we can not increase the resulting accuracy of the model past the inital best of 20 epoch. This being said when testing machine learning models there may be a certain ratio between learning rate and epoch to slightly increase the accuracy but from our testing we could not find this said ratio.
<br/>

### Layer Freezing
Layer Freezing controls the way the weights are updated. We applied layer freezing on the DenseNet and RegNet models.

We first tried layer freezing on the DenseNet models by freezing the first few layers in each of the dense blocks. Based on the resutls, the testing accuracy decreased slightly as more layers were frozen while the training accuracy stayed roughly the same.

<br/>
<div align="center" style="display: grid; margin-top: 5%; margin-bottom:2%; justify-content: center">

| | Testing Accuracy| Training Accuracy|
|:------------:|:----------------:|:------------:|
|**No Layer Freezing** | 63.01%|    98.24%    |
|**2 Layer Freezing** |    61.44%   |  98.44%    |
|**4 Layer Freezing** |   57.19%    |   98.22%      |

</div>
<br/>

We then tried layer freezing on the RegNet models by freezing the first few layers in each block. We obtained similar results where the testing accuracy decreased slightly.

<div align="center" style="display: grid; margin-top: 5%; margin-bottom:2%; justify-content: center">

| | Testing Accuracy| Training Accuracy|
|:------------:|:----------------:|:------------:|
|**No Layer Freezing** | 66.44%|    98.24%    |
|**2 Layer Freezing** |    64.38%   |  97.75%    |
|**5 Layer Freezing** |   63.69%    |   97.97%      |
|**8 Layer Freezing** | 63.01%|    97%    |
|**12 Layer Freezing** |    59.59%   |  97%    |

</div>

From the above results, we can conclude that layer freezing does not help increase the accuracy of the models.

<br/>

### Image Augmentation

**We used two strategies to do image augmentation**

#### First Strategy
The first strategy we used is to change the background for some of the car images in our training dataset that had white backgrounds. We did this to add some noise to the images so the model will be able to better generalize. Below you see the code for changing the background. It takes 3 parameters, one is the src path, and one is the background src path. It will then combine the two images and produce a new image and store it in the destination path.

We were expecting this will help increasing the performance of the model, but it actually hurt the performance. We assume that this could be the result of the background we added which is adding too much noise. This in turn is making it harder for the model to learn and generalize.

```python
# Function to change the background
def changeImgBg(srcPath:str, bgSrcPath:str, destPath=""):
    # srcPath: path of the src image
    # bgSrcPath: path of the background src image
    # destPath: destination path
    
    # read the src image
    img = cv2.imread(srcPath)
    
    # get the mask image
    lower_white = np.array([245,245,245]) 
    upper_white = np.array([255,255,255])
    mask = cv2.inRange(img, lower_white, upper_white)
    
    # show the image without background
    masked_img = np.copy(img)
    masked_img[mask != 0] = [0, 0, 0]
    
    # read the new background image
    bg_img = cv2.imread(bgSrcPath)
    bg_img_resized = cv2.resize(bg_img, (300,300))
    
    corp_bg = np.copy(bg_img_resized)
    corp_bg[mask == 0] = [0,0,0]
    
    # output image
    output_img = corp_bg + masked_img
    
    # saving the output image
    if destPath != "":
        cv2.imwrite(destPath,output_img)
    return output_img
```

#### Second Strategy

The second strategy we used is to split the car images to left and right pieces. We did to make the model more general and realized more or less simulate the images taken with a phone camera. Most of time, when we take a picture using our phone camera we cannot get the entire image of the car. So spliting the images into pieces we assumed would help the model generalize and not rely too much on what the entire car data available in the image.

This method in the end did increase the performance of the model just as we had hoped. For any pretrained models we mentioned earlier, using this image augmentation will increase the testing accuracy at least 2~3%.

```python
# Function to slice the image to half
def sliceImg(srcPath:str, leftPath="", rightPath=""):
    # srcPath: path of the src image
    # leftPath: path of the left part image
    # rightPath: path of the right part image
    if leftPath == "" or rightPath == "":
        return
    
    # read src image
    img = cv2.imread(srcPath)
    # calculate the width and height
    height, width = img.shape[0], img.shape[1]
    mid =  width // 2
    
    # slice image
    leftImg = img[0:height, 0:mid]
    rightImg = img[0:height, mid:width]
    cv2.imwrite(leftPath,leftImg)
    cv2.imwrite(rightPath,rightImg)
    
    return leftImg, rightImg
```
<br/>

### Add more classes to the training dataset
One thing we tired at the behest our professor was to add more car models to the training dataset. The new trained model with more classes did not have much improvement in accuracy.

Initially we had 23 car classes, and then we added more car images to our dataset and increased the number of car classes to 40. The performance of the model did get hurt, and the testing accuracy dropped about 10%.

Right now for a better user experiecne we decided to only keep the number of models to 23. For the future, we are thinking of added app features to help us retrain the model and then increase the number of car models at gradual pace. You can read more in the [future outlook session](###App-Development).

<br/>


### Change fully connected layer

After all the previous different experiments we tried to check and play around with the fully-connected layer of the RegNet_y_3_2gf model considering that was our best model. For this we tried different architectures for the fully connected layer. We did this because most of the time these pre-trained models were generally trained on the ImageNet dataset which consisted of 1000 different classes. So, their fully connected layer was would go from some value x to 1000. In our case at the start we would just add another Linear layer which would go from 1000 to 23 (*like below*). But this was a rather inefficient approach, mainly because we were going from a very large number of features to a small number of features very quickly. This mean't that the model might be losing some valuable information or might not even be able to identify the important information properly. Hence, we attempted to improve this by changing the entire fully connected layer.
```
nn.Linear(in_features=1000, out_features=23, bias = True)
```

#### Attempt #1
Our first experiment was what if we changed the fully connected layer to the following : 1000 x 400 x 23 (*code shown below*). This first attempt was just a base line to see what would happen.
> 1000 x 400 x 23 would be we would go from 1000 in features to 400 out features and then use that 400 out features to go to 23 features which represents the total number of car classes we have.
```
model.fc = nn.Sequential(
    model.fc,
    nn.Linear(in_features=1000, out_features=400, bias = True),
    nn.Linear(in_features=400, out_features=23, bias=True)
)
```
After, training the RegNet_y_3_2gf using this new fully connected layer architecture and 20 epochs we got the following results.

```
70.55% : Image Size - 263
70.21% : Image Size - 288
69.86% : Image Size - 272
```

From this we noticed that our accuracy increased by over 6%. This was quite a significant improvement hence, we decided to play around with the fully connected layer even more to observe the changes.

#### Attempt #2
For our second attempt at modifying the fully connected was to consistently make the out features half of what the in features were. So, once we did this, our fully connected layer was the following : 1000 x 500 x 250 x 125 x 60 x 23 (*code shown below*). Our hypothesis was that cutting the features in half all the way through would help the model retain more significant information and therefore produce better results. We assumed that during each reducation the model will be better able to understand the data and make a better judgement for the final output.

```
model.fc = nn.Sequential(
    model.fc,
    nn.Linear(in_features=1000, out_features=500, bias = True),
    nn.Linear(in_features=500, out_features=250, bias=True),
    nn.Linear(in_features=250, out_features=125, bias=True),
    nn.Linear(in_features=125, out_features=60, bias=True),
    nn.Linear(in_features=60, out_features=23, bias=True)
)
```
After, training the RegNet_y_3_2gf using this new fully connected layer architecture and 25 epochs we got the following results.

```
68.49% : Image Size - 275
66.44% : Image Size - 256
65.75% : Image Size - 260
```

From this we noticed that our accuracy decreasd by 2% from the previous attempt. This was bad. Initially our assumption was that we trained this model for 25 epochs instead of 20. This was a rather a stupid assumption but we assumed maybe it was overfitting. But, even after training on 20 epochs the accuracy did not improve nor did it come close. After this we decided that maybe going half was not the right choice and that we were wrong to assume that the accuracy was going to improve.

#### Attempt #3
For this attempt we decided lets use the first attempt fully connected layer architecture (*our base*) and then add one more linear layer in between. Esentially we changed our fully connected layer to the following : 1000 x 400 x 150 x 23
```
model.fc = nn.Sequential(
    model.fc,
    nn.Linear(in_features=1000, out_features=400, bias = True),
    nn.Linear(in_features=400, out_features=150, bias=True),
    nn.Linear(in_features=150, out_features=23, bias=True)
)
```
After, training the RegNet_y_3_2gf using this new fully connected layer architecture and 20 epochs we got the following results.
<br/>

```
70.89% : Image Size - 288
70.55% : Image Size - 284
70.21% : Image Size - 262
```

With this new change in the fully connected layer architecture our accuracy increased 0.34%. Althought, this accuracy was not really that significant we figured out approach was going in the right direction.

So, we doubled down and decided to train the model for 25 epochs and well got the following result. [Model Link](https://ccnymailcuny-my.sharepoint.com/:u:/g/personal/nprajit000_citymail_cuny_edu/EQZnwKKyPjBEh-HfUuzYNF0Bd2ns73jp4gBwsgWaXs0X2A?e=C6fSFf)

```
71.23% : Image Size - 256
```

Our accuracy increased by close to 0.70% from the base line. A rather good improvement but still we had a long way for improvement.

Taking a look at the categorical breakdown on the testing dataset as to how the model performed on individual categories we described in the [testing dataset](###Testing-Dataset) section, we got the following results.

```
Classic Cars : 68.89%
Far : 82.35%
Back & Side : 86.67%
Side : 68.42%
Front & Side : 77.32%
Front : 67.14%
Back : 59.65%
```

Looking at the categorical breakdown results, we see that this model performs best when the car is far in the image or the back & side of the car is shown in the image. In terms of classic cars the accuracy is not that great which is a bit disappointing as the main purpose of the app is to recognize super unqiue cars. Overall this is a good model with a good accuracies across each category.

<br/>


### Ensemble Learning
After doing experiments with the fully connected layer. We decided it was time to new approach. After doing some reasearch he came to learn about a machine learning approach called **Ensemble Learning**. Ensemble learning is the process by which multiple models, such as classifiers or experts, are strategically generated and combined to solve a particular problem. It is primarily used to improve the performance of a model, or reduce the likelihood of an unfortunate selection of a poor one. We came to know about ensemble learning due to Kaggle competitions (*we were using Kaggle to train our models*) where winners frequently tend to use this learning method to improve their ML and achieve better prediction. In fact, we were suprised to learn that some of the best ImageNet dataset classification models also made use of this approach to achieve better accuracy.

In our case we used **Stacking Ensemble** a type of ensemble learning where you take multiple models and give the output from these models to a new model which then produces the final output. You can read more about this type of ensemble learning and others [here](https://machinelearningmastery.com/tour-of-ensemble-learning-algorithms/). 

#### Attempt #1
For our first attempt we tried to create a new model with three of our previous models specifically, RegNet_y_3_2gf [1000_400_150_23] (71.23%, 25), RegNet_y_3_2gf [1000_400_23] (70.55%), and RegNet_y_3_2gf [1000_400_150_23] (70.89%, 20). The ensemble code is provided below. 

```python
class EnsembleModel(nn.Module):
    def __init__(self, modelA, modelB, modelC):
        super().__init__()
        self.modelA = modelA
        self.modelB = modelB
        self.modelC = modelC
        self.classifier = nn.Linear(23 * 3, 23)

    def forward(self, x):
        x1 = self.modelA(x)
        x2 = self.modelB(x)
        x3 = self.modelC(x)
        x = torch.cat((x1, x2, x3), dim=1)
        out = self.classifier(x)
        return out

ensemble_model = EnsembleModel(regnet_v6, regnet_v4, regnet_1000x400) 

for param in ensemble_model.parameters(): 		       
    param.requires_grad = False 

for param in ensemble_model.classifier.parameters(): 
    param.requires_grad = True 

ensemble_model = ensemble_model.to("cuda:0")
```

**NOTE :** Our linear layer takes 69 in features because each model outputs 23 values. And since we have 3 model each outputting 23 values we have 69 total in features (23 * 3 = 69).

**NOTE :** `requires_grad = True` enables weights of the models to be updated during training. If it is `False` then the current weights will be frozen and will not update during training.

After, building the model and training the model for 25 epochs with different learning rates we got the following result.

**Learning rate 0.007** [Model Link](https://ccnymailcuny-my.sharepoint.com/:u:/g/personal/nprajit000_citymail_cuny_edu/ES6OWDUmx4tPs6UeJjVUa-8BbfVWEcxPMu-Zmu3VLmnEoQ?e=Pi3P1R)

Testing Accuracy
```
72.26% : Image Size - 288
```

Categorical Breakdown
```
Classic Cars : 73.33%
Far : 94.12%
Back & Side : 86.67%
Side : 73.68%
Front & Side : 76.29%
Front : 67.14%
Back : 63.16%
```

**Learning rate 0.01** [Model Link](https://ccnymailcuny-my.sharepoint.com/:u:/g/personal/nprajit000_citymail_cuny_edu/Eaw4iWF6MNVLteV1tje5BO4BFW_E6gan9XtWX6Ybb96_1A?e=Z1TLgn)

Testing Accuracy
```
72.95% : Image Size - 271
```

Categorical Breakdown
```
Classic Cars : 73.33%
Far : 88.24%
Back & Side : 86.67%
Side : 71.05%
Front & Side : 76.29%
Front : 67.14%
Back : 68.42%
```

From this, we can conclude two things. Firstly, have a learning rate of 0.01 produces a better result than one with a learning rate of 0.007. In addition, ensemble learning does work. For both the models we increased our accuracy by over 1%. Enspecially the model with learning rate of 0.01 the accuracy increased by over 1.5%. 

Looking at the categorical breakdown it was the model with the learning rate of 0.007 does seem to out perform the model with the learning rate of 0.01 in `Far` and `Side`. But the latter is doing better in the `Back` category. Overall, it is bit hard to say which model is better considering their varing strengths in different categories.


#### Attempt #2
For our second attempt we tried to create a new model with four of our previous models specifically, RegNet_y_3_2gf [1000_400_150_23] (71.23%, 25), RegNet_y_3_2gf [1000_400_23] (70.55%), RegNet_y_3_2gf [1000_400_150_23] (70.89%, 20), and DenseNet_161 (69.52%, 20). The ensemble code is provided below.

```python!
class EnsembleModel(nn.Module):
    def __init__(self, modelA, modelB, modelC, modelD):
        super().__init__()
        self.modelA = modelA
        self.modelB = modelB
        self.modelC = modelC
        self.modelD = modelD
        self.classifier = nn.Linear(23 * 4, 23)

    def forward(self, x):
        x1 = self.modelA(x)
        x2 = self.modelB(x)
        x3 = self.modelC(x)
        x4 = self.modelD(x)
        x = torch.cat((x1, x2, x3, x4), dim=1)
        out = self.classifier(x)
        return out

ensemble_model = EnsembleModel(regnet_v6, regnet_v4, regnet_1000x400, densetnet_161) 

for param in ensemble_model.parameters(): 		       
    param.requires_grad = False 

for param in ensemble_model.classifier.parameters(): 
    param.requires_grad = True 

ensemble_model = ensemble_model.to("cuda:0")
```

**NOTE :** In this attempt our linear layer takes 92 in features because to account for the 23 new values we get from the addition of a new model. (23 * 4 = 92).

After, building the model and training the model for 25 epochs with different learning rates we got the following result.

**Learning rate 0.007** [Model Link](https://ccnymailcuny-my.sharepoint.com/:u:/g/personal/nprajit000_citymail_cuny_edu/EdblONSEdyBGsdzf-HJulx8BaSgZO3l7ypCtXtPcNduHfg?e=Y96QW5)

Testing Accuracy
```
71.92% : Image Size - 285
```

Categorical Breakdown
```
Classic Cars : 75.56%
Far : 94.12%
Back & Side : 83.33%
Side : 73.68%
Front & Side : 77.32%
Front : 65.714%
Back : 63.16%
```

**Learning rate 0.01** [Model Link](https://ccnymailcuny-my.sharepoint.com/:u:/g/personal/nprajit000_citymail_cuny_edu/EdmxzVjEpiNOg_ZN7Tt9R1kBSSY6zWUIeyiO1KvxvfhdTg?e=THzOo9)

Testing Accuracy
```
72.60% : Image Size - 265
```

Categorical Breakdown
```
Classic Cars : 73.33%
Far : 88.24%
Back & Side : 90.00%
Side : 71.05%
Front & Side : 77.32%
Front : 67.14%
Back : 63.16%
```

After this experiment we noticed that out overall accuracy went down just slightly by 0.35%. But taking a closer look at the categorical breakdown results of themodel with a learning rate of 0.01 a different conclusion could be made. 

In the case of the model with a learning rate of 0.01, the `Back & Side` category got an accuracy of 90%. This was more than anything we have seen so far. In other categories this model seemed to struggle but, it is still good to know that there is room for potential improvement.
<br/>
After the two attempts, we concluded that in our testing of the ensemble models we noticed that it does help with improving the accuracy. However, adding an additional model (DenseNet) to the original three did not really make much of a difference to the model. 

Once, we were reached the above conclusion we took a look back at the code so far and decided to try a different approach. 
<br/>

#### Different Approach
Instead, of the final classifier layer being linear like in the model attempts before. We decided to try and see what would happen if we gave it a pre-trained model. Specifically the RegNet_y_3_2gf with the FC layer architecture of 1000 x 400 x 150 x 23. The code of this approch is shown below.

```python!
class EnsembleModel(nn.Module):   
    def __init__(self, modelA, modelB, modelC, modelD):
        super().__init__()
        self.modelA = modelA
        self.modelB = modelB
        self.modelC = modelC
        self.classifier = modelD
        
    def forward(self, x):
        x1 = self.modelA(x)
        x2 = self.modelB(x)
        x3 = self.modelC(x)
        
        x1 = x1.to('cpu').numpy()
        x2 = x2.to('cpu').numpy()
        x3 = x3.to('cpu').numpy()
        
        x = []
        for i in range(len(x1)):
            temp = [[x1[i]], [x2[i]], [x3[i]]]
            x.append(temp)
        x = torch.tensor(x)
        x = x.to("cuda:0")
        out = self.classifier(x)
        return out

ensemble_model = EnsembleModel(regnet_v6, regnet_v4, regnet_1000x400, regnet)

for param in ensemble_model.modelA.parameters():
    param.requires_grad = False

for param in ensemble_model.modelB.parameters():
    param.requires_grad = False

for param in ensemble_model.modelC.parameters():
    param.requires_grad = False
    
for param in ensemble_model.classifier.parameters():
    param.requires_grad = True

ensemble_model = ensemble_model.to("cuda:0" if torch.cuda.is_available() else "cpu")

```

After, building the model and training the model for 25 epochs with a learning rate of 0.008 we got the following results.

[Model Link](https://ccnymailcuny-my.sharepoint.com/:u:/g/personal/nprajit000_citymail_cuny_edu/EUEBZ2LQx59DsYK4uEor9nQBLBfw5FhXcF3QENXEseuL4A?e=c6E8ET)

Testing Accuracy
<div style="display: grid; justify-content:center; margin-bottom:4.5%; row-gap:1.5%">
	<div>
		<h2 style="text-align: center">72.26%</h2>
        <p style="color:grey">Image size : 242<p>
    </div>
</div>
```
72.26% : Image Size - 242
```

Categorical Breakdown
```
Classic Cars : 73.33%
Far : 88.24%
Back & Side : 90.00%
Side : 71.05%
Front & Side : 77.32%
Front : 67.14%
Back : 61.40%
```

After this experiment we noticed that our overall accuracy went down just slightly by 0.70%. In terms of the categorical breakdown the accuracies remained consistent compared to the previous models. There was nothing too distinct or attracted attention in this experiment. We were pretty disappointed that this approach did not produce a better result and we had high hopes this might yield fruit.
<br/>

#### Conclusion 
In conclusion, we think ensemble modeling has a lot of potential for improvement and testing. We think, with more time this approach could have proved to be valuable and provided us with great results.

<br/>


## Running the flutter app
**YOU MUST HAVE FLUTTER INSTALLED AND FIREBASE CONNECTED BEFORE RUNNING THE APP!**

### Real Device

To run the code on an real android device. First the user must plug in the device to their machine. Next follow the code written below
```bash!
git clone https://github.com/NishanthPrajith/carIdentificationApp.git
cd carIdentificationApp/AppFiles/
flutter pub get # Install the libraries
flutter devices
```
After running ```flutter devices``` you should see a list of the devices connected to your machine which can run flutter. Here you should see your physical device. 

If you do not see it you will need to go back and check to see if *USB debugging* is turned on the device's *Developer Settings*. Once, it is turned on you can try running ``flutter devices`` again to see if it worked.

If you do see your device, you can run the code below and, just select the number associated with your device and wait for flutter to install the app on your device.
```bash!
flutter run
```

### Android Simulator
While it is possible to run the app using an Android Simulator it is designed to run on a physical device, which may cause some errors. To be able to run the application on an android simulator one must have a physical camera connected to the simulator. For example, a webcam, etc..

To run the app on an android simulator one must first create an Android Virtual Device. This step is important because we will be using an emulator and each instance of the Android Emulator uses an Android Virtual Device. To create an Android Virtual Device, we must first launch android studios and open device manager, this will allow us to create our device by selecting a certain Hardware (It does not matter which one you choose but it is recommended to choose a more recent Hardware). Our Next step is to choose a Hardware profile this could be one of the given profiles or you can create/import a hardware profile. Our final step is to select a system image for a particular API level. (It is recommended to choose an API from the recommended tab since they will most likely run the best).

Once we have our Android Virtual Device, we can start the Android Emulator and run the app. To select the Android Virtual Device you want, go to the toolbar and select the specific Android Virtual Device. Then click run, it may take a couple of minutes to boot up. Once downloaded it will be on the device like any other physical device.
<br/>

## Instructions on Training The Model
To train the model you will need to download one of our notebooks with the code as well collect the necessary training dataset. In this section we will try to explain how we trained the models for our purposes, which you can then use for yours.

**NOTE : You will not be able to train an model unless you have a GPU or have access to a service that provides a GPU for training machine learning models (specifically neural networks) such as *Kaggle*.**
**Although, google colaboratory is good option, our personal testing proved the amount of RAM provided was insuffucient for training purposes.**

Firstly, you will need to gather the training dataset. Which you can read more about in the [ML dataset description](###Training-Dataset).

Once, the training dataset is gathered then it is time to download one of the model training code notebooks for training the model. For this example, we will use the ```iihoobnu.ipynb``` notebook found [here](). Once downloaded open the notebook into your respective editing environment along with the dataset. You will need to replace the path to your dataset in the notebook. Inside you should see.
```bash!
# Loading dataset
dataset_dir_train = "../input/training-dataset-v6/finalDataset"
```
Here, you must replace the path to the training dataset with respect to your environment.

Next, you need to enable GPU acceleration. In Kaggle it is basically selecting the accelerator from the dropdown on the right side. In google colaboratory it is ```Runtime > Change Runtime``` and then selecting ```GPU``` under **hardware accelerator**. So please do the same thing in your editing software environment as it important for training the model.

After selecting the accelerator you can run the notebook (all of the code blocks) and wait for it to finish. Once, the notebook is done training the notebook will automatically save a ``.pt`` file which you then use for testing.

One thing we did not mention here is changing the architecture of the model. For this you can either write your own custom architecture or you wish to replicate our experimental results you can copy the code from the respective experiment section in [here](). Once, you do create the custom architecture or pre-trained model you can run the code and have it been trained.

**IMPORTANT : If you wish to use this model on the flutter app you will need to follow some more steps which is outlined below.**

#### Create model for the app

Firstly, load the model like so
```base~
model = torch.load("path-to-model")
```
Next, run the following code
```bash~
model_save = torch.jit.trace(model,torch.rand(1,3,300,300).to(device))
model_save.save("flutter-app-model.pt")
```
Once, you run the code a new ``.pt`` model will be saved under the name ``flutter-app-model.pt``. If you wish for the model to accept a different input image size you are free to change ```torch.rand(1,3,300,300)```. For example, if you wish for the input image size to be ``256`` by ``124`` then the code will be ```torch.rand(1,3,256,124)```.

Once you do all that you will need to go to the `assets` folder in the app directory and create a new folder called `models` and place your model (`.pt` file) in there.

It is important that once you do the above you must replace this line of code in the `classifier.dart` file with the path to your model. 
```python
Model imageModel = await PyTorchMobile.loadModel("path-to-model");
```

#### Hyperparameters
You can furthur play around with the training code by changing the loss and optimizer functions along with the learning rate (*`lr` is the learnign rate*).
```python
lossFun = nn.NLLLoss()
optimizer = optim.SGD(model.parameters(), lr=0.005, momentum=0.9)
lrscheduler = optim.lr_scheduler.ReduceLROnPlateau(optimizer, mode='max', patience=2, threshold = 0.9)
```

If you wish to change the number of epochs (*training iterations*) you can edit the following line of code replacing `epochs` with whatever number you feel. But, caution yourself from make the number extremely large as that would mean the training time would be very long.
```bash~
model, training_losses, training_accs = TrainModel(model, lossFun, optimizer, lrscheduler, n_epochs=25)
```
The `TrainModel` function is provided below, this function is good for a reuse purpose. **Be careful if you use a different loss function rather that `NLLLoss` that we chose. You may need to modify the code a little bit to get it to work.**
```python
# function to train the model
def TrainModel(model, lossFun, optimizer, scheduler, n_epochs=5):
    losses = []
    accuracies = []
    
    model.train()
    
    for epoch in range(n_epochs):
        since = time.time() # record the start time
        running_loss = 0.0
        running_correct = 0.0
        counter = 0
        for i, data in enumerate(trainloader, 0):
            
            inputs, labels = data
            # Asigning GPU
            inputs = inputs.to(device)
            labels = labels.to(device)
            
            optimizer.zero_grad()
            counter += len(inputs)
            outputs = model(inputs)
            m = nn.LogSoftmax(dim=1)
            _, predicted = torch.max(outputs.data, 1)
            loss = lossFun(m(outputs), labels)
            loss.backward()
            optimizer.step()
            
            running_loss += loss.item()
            running_correct += (labels==predicted).sum().item()

        timeSpent = time.time()-since # time used
        epoch_loss = running_loss/counter
        print(running_correct, counter)
        epoch_acc = 100*(running_correct/counter)
        print("Epoch %s, Time Used: %d s, loss: %.4f, acc: %.4f" % (epoch+1, timeSpent, epoch_loss, epoch_acc))
        
        losses.append(epoch_loss)
        accuracies.append(epoch_acc)
        scheduler.step(epoch_acc)
    print('Training Finished')
    return model, losses, accuracies
```

<br/>

## Instructions on Testing The Model
Before testing the model you need to ensure it is not saved using the `torch.jit.trace(...)` otherwise the testing code will not work. Next you need to pick the right testing notebook based on the model you are testing. If it is an ensemble model the code is provided [here](). If it is not an ensemble model the code is provided [here]().

**DO NOT FORGET TO TURN ON THE GPU!**

First load the appropriate model and testing dataset. This is done by replacing the following line in the notebook.
```bash
MODEL = "path-to-model"
TEST_DATASET = "path-to-dataset"
```
For you are using your own testing dataset please replace this line of code with the path to your dataset. It should end in `.zip`.
```
!unzip testset3.zip | wc -l
```

Next, run all the code blocks until the `for` loop which goes through all the different images sizes ranging from `224` to `310`. Once this particular code block runs completely you will see an output which lists all the different accuracies for each different image size along with the highest accuracy along with its respective image size. *The code block and a sample highest accuracy output is shown below.*

*Code Block*
```bash
HighestAccuracy = 0
ImageSize = 0

for i in range(224, 227):
    print(i)
    test_dataset = TEST_DATASET
    test_transform = transforms.Compose([transforms.Resize(i),
                        transforms.ToTensor(),
                        transforms.Normalize((0.485, 0.456, 0.406), 
                                             (0.229, 0.224, 0.225))])

    dataset = torchvision.datasets.ImageFolder(
      root=test_dataset, transform = test_transform)
    testloader = torch.utils.data.DataLoader(dataset, batch_size = 1, 
      shuffle=False, num_workers = 2)

    model = torch.load(MODEL)
    model.eval()
    info = EvaluateModel(model)
    
    if info[2] > HighestAccuracy:
        HighestAccuracy = info[2]
        ImageSize = i

print("")
print("The best accuracy is " + str(round(HighestAccuracy, 2)) + 
            "% and the image size is " + str(ImageSize))
```

*Sample Output*
```bash
The best accuracy is 70.33% and the image size is 225
```

Finally, you can run the rest of the code blocks and get a more detailed insight into how the model performed in each category for the image size with the best accuracy as described in the [testing dataset description](###Testing-Dataset).

After running the entire notebook you should see an output like what is shown velow with each category and its accuracy, correct and incorrect count.
```
classic_cars : 71.11%     - correct 32   incorrect 13
front-side : 76.29%       - correct 74   incorrect 23
front : 68.57%            - correct 48   incorrect 22
side : 71.05%             - correct 27   incorrect 11
back : 64.91%             - correct 37   incorrect 20
back-side : 86.67%        - correct 26   incorrect 4
far : 88.24%              - correct 15   incorrect 2
```

<br/>

## What We Learned
One of the biggest things we learned was about the software development cycle (agile). This was the first real-world project without constraints provided by the professor, so being on task was critical to finishing the project. Hence, we as a team worked like how we would if this was a real project in a company and we enacted the agile life cycle model with weekly meetings and daily updates.

Another lesson we have learned is to understand how to debug. Considering this project was something all of us experienced for the first time, we naturally ran into a lot of bugs which we did not understand. And so, one of the things we picked upon is how to debug properly and look for clues that can help lead to the solutions by understanding the errors and behavior of the code.

Lastly, we have learned how to work with a machine learning models and a mobile application. In this project, we made use of a database and a machine learning model along with a mobile application which is something we as a team have not experienced in the past. So this was an entirely new experience for all of us. In the beginning it was hard but over time we all got used to it and we think right now we all have a really good fundamental grasp of how to build software's that has an ML component as part of it.

<br/>

## Challenges Faced

#### Good Performance Metric
One key challenge we faced was to come up with a good performance metric. This required us to obtain a representative testing dataset. Since the image that the machine learning model classifies is taken by the user in real-time, we needed a testing dataset of real car images that the users might take. In order to obtain such a meaningful testing dataset, we used our phones to take images of cars that we see on the streets at different angles. In addition, we made use a search engine and downloaded some images to obtained a representative testing dataset of 300 car images. Once, we found the images, we labelled them in specific fashion to understand how the model performed on the specific types of a images. Such as, one with the car really far, or only the front side of the car being shown. These things were meant to help us understand what needed to be fixed and in which areas the model lagged behind.

#### Increase model accuracy
Another challenge we faced was trying to increase the accuracy of our image classification models. It was difficult to figure out which approach would help increase the accuracy of the model so we ended up trying many different experiments to see which one would produce the best accuracy.

#### Embed the ML model to the flutter app
During the initial stages of the project, our plan was to host the PyTorch model on *Firebase Machine Learning* a service provided by *Firebase*. But, we soon realized this was not going to be possible. For one, *Firebase Machine Learning* does not support a PyTorch model, it only support TensorFlow model. Our work around for this was to use [ONNX](https://onnx.ai/), which is an open source file format built to represent machine learning models. With the use of ONNX we can then convert the PyTorch model into a TensorFlow model. The code is provided [here](https://colab.research.google.com/drive/1BNok28YCY5ar8PCHUBGIrVzS1QS3vTDo) if you wish to use it. Unfortunately even though we solved that problem we could not figure out to properly use *Firebase Machine Learning*. There was not a lot of documentation or answers to bugs we were running into. Hence, we need to a new strategy and pivot.

Our new strategy was to directly embed the model into the flutter app using the `tflite: ^1.1.2` flutter package (found [here](https://pub.dev/packages/tflite)). But this also had a flaw. Using the `tflite` flutter package meant that we can no longer resize the images to our specification, and normalize the image using mean and standard deviation. To do this we wrote a function which applied the resizing and normalized the image. But the main problem was that flutter reads image data as `INT` instead of `FLOAT` which is what we want it to be. We want `FLOAT` because our original model was trained to accept images to have `FLOAT` values for the image data. If we suddenly change it to `INT` we will lose valuable information and the model might not be able to classify correctly.

Our solution was to use the `pytorch_mobile` flutter package (found [here](https://pub.dev/packages/pytorch_mobile)) and use the original PyTorch model without ONNX conversion. This worked out great and had everything we were looking for. The only thing was we needed to save the model using `.jit.trace` which you can read more about how to use [here](####Create-model-for-the-app).

<br/>

## Future Work 
Describe what work needs to be developed on this project to
make it a fully-usable product. Discuss both improvements to the usability and
design as well as testing.

In terms of app design we think the app is in a very good place. We think the UI and UX in its current stage to very clean and intuitive. The other work that needs to be completed is seperated in three sections *App Development*, *Machine Learning Improvement*, and *Testing*.

In terms of usability we will need to fix the fact the app is currently only working on Android. We will need to ensure it also works fine on an iPhone as that is a large target demographic.

### App Development
1. In term of usability, the app is only working on android devices. We would need the app working on iOS which in its current stage is not working due to some permission issues with the camera. So, this would require debugging but also changing a bit of the codebase to adhere to apple's strict privacy standards.
2. Another thing we will need to do before developing this into a consumer grade product is fixing the camera issue. Currently, the app crashes after taking around 20 pictures at the same time. This would need to be fixed in the long run for a fully-usable product as to not mess with the usability.
3. Sometimes users will try to classify a car model that is not in our database. We can add a new feature to let users upload car images for these car. After we collect a good amount of images for these car models, we can then add new classes to our model. 

### Machine Learning Improvement
1. Adding the machine learning model directly into the app currently has a strain on the storage as the model most of the time has a file size of around 150-200MB. This causes the overall app size to be around 400MB most of time. To reduce the app size for the future we could try to move the model into a server (API) for easy use. This would also mean that we can deploy a newer model quickly without the need for each user updating the app for a newer model.
2. Next, for the full-scale final product we could consider modifying the model to learn from its mistakes (reinforcement learning). This would essentially work with the help of the user who would identify the misclassifications and help with the re-training of the model to prevent such misclassifications in the future. This could be done in the beta stage of the app.
3. We also need to add more classes to our model. Even though adding more classes will hurt the performance of our model as we tested. 23 is not enough for a consumer-grade product. It is good if we can increase the number to 100 or higher.
4. Finally, although this is a long shot, we could try a different approach to classification. Instead of training one model we can train multiple models for each of car type (sedan, hatchback, pickup, etc). Finally, we can have a new model which will categorize what car type the car in the image falls under and then depending on that we will call the appropriate model for classification. This could potentially provide better accuracy. In fact, for this approach we are not limited to the car type, we can try to separate the models by the car brand (Ferrari, BMW, etc) as well to see how that does.

### Testing
1. One thing we need to do before developing this into a consumer-grade product in terms of testing is to run more tests on the ML model and also experiment with different training datasets. We saw that splitting the original training dataset into a left and right piece increased the accuracy significant over +10%. So, who is to say that it is not possible to push it further. Hence, we need to perform more testing to see what could be achieved.
2. Another thing we could do in terms of testing is to analyze what the best model we trained learned by looking at the visualization of weights in the convolutional layer after training. We tried to do this but failed to get it to work. But with more time, spending some time looking at the visualization will get help us better understand how the model learns and where it needs improvement.  

<br/>

## Theoretical Roadmap
This is a theoretical roadmap for the future direction of this app if we were to develop this into a fully functioning consumer-grade product.
1. The first thing we want to do is release the app in to the App store and Play store for beta testing. As mentioned earlier, we are currenly experiencing a camera issue, and we will fix that first before releasing. After we fixed all the issues, people with both android and apple devices should be able to use our app.
2. Perform more experiments and improvements based on user feedback. This will include adding more features based on user feedbacks. For example, we are thinking of adding a feature to let the user provide feedback to indicate if the classification is correct or not, and for each prediction, we will store the image to our server. 
3. Add more car models for classification. For this users we will be able to upload data (car images) for the model that we currenly don't have in our database. And we will retrain the model after a period of time. All of these will eventually help us improve the user experience and the performance of the model.
4. Adapt the final model for other use cases such as car seller verification in the form of an API. 

<br/>

## Resources
- [PyTorch.org](https://pytorch.org)
- [PyTorch_Mobile Flutter Package](https://pub.dev/packages/pytorch_mobile)
- [PyTorch PreTrained Models Documentation](https://pytorch.org/vision/stable/models.html)
- [Flutter](https://flutter.dev)
- [Firebase Firestore](https://firebase.google.com/docs/firestore)
- [Firebase Auth](https://firebase.google.com/docs/auth)
- [Ensemble Learning Medium Article](https://medium.com/@alexppppp/how-to-train-an-ensemble-of-convolutional-neural-networks-for-image-classification-8fc69b087d3)
- [Ensemble Learning Introduction](https://machinelearningmastery.com/tour-of-ensemble-learning-algorithms/)
- [Stanford Cars Dataset](http://ai.stanford.edu/~jkrause/cars/car_dataset.html)
- [DVM Dataset](https://deepvisualmarketing.github.io/)
- [Car Connection Picture Dataset](https://www.kaggle.com/datasets/prondeau/the-car-connection-picture-dataset)
- [Google Image Downloader code](https://github.com/Joeclinton1/google-images-download)

<br/>

## The Team
This project is the combined effort of [Nishanth Prajith](https://github.com/NishanthPrajith), [Yue Qian](https://github.com/yqian000), [Kareem Elsheikh](https://github.com/KareemElsheikh1), and [Xiaohu Zheng](https://github.com/ZhengXiaohu98). We each played individual roles with Nishanth, Yue, and Kareem working on the front-end app and Xiahou initally working on the Machine Learning model before a conjoined effort by everyone to improve the model after the completion of the front-end app.
