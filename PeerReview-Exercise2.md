# Peer-Review for Programming Exercise 2 #

## Description ##

For this assignment, you will be giving feedback on the completeness of assignment two: Obscura. To do so, we will give you a rubric to provide feedback. Please give positive criticism and suggestions on how to fix segments of code.

You only need to review code modified or created by the student you are reviewing. You do not have to check the code and project files that the instructor gave out.

Abusive or hateful language or comments will not be tolerated and will result in a grade penalty or be considered a breach of the UC Davis Code of Academic Conduct.

If there are any questions at any point, please email the TA.   

## Due Date and Submission Information
See the official course schedule for due date.

A successful submission should consist of a copy of this markdown document template that is modified with your peer review. This review document should be placed into the base folder of the repo you are reviewing in the master branch. The file name should be the same as in the template: `CodeReview-Exercise2.md`. You must also include your name and email address in the `Peer-reviewer Information` section below.

If you are in a rare situation where two peer-reviewers are on a single repository, append your UC Davis user name before the extension of your review file. An example: `CodeReview-Exercise2-username.md`. Both reviewers should submit their reviews in the master branch.  

# Solution Assessment #

## Peer-reviewer Information

* *name:* Penelope Phan
* *email:* peaphan@ucdavis.edu

### Description ###

For assessing the solution, you will be choosing ONE choice from: unsatisfactory, satisfactory, good, great, or perfect.

The break down of each of these labels for the solution assessment.

#### Perfect #### 
    Can't find any flaws with the prompt. Perfectly satisfied all stage objectives.

#### Great ####
    Minor flaws in one or two objectives. 

#### Good #####
    Major flaw and some minor flaws.

#### Satisfactory ####
    Couple of major flaws. Heading towards solution, however did not fully realize solution.

#### Unsatisfactory ####
    Partial work, not converging to a solution. Pervasive Major flaws. Objective largely unmet.


___

## Solution Assessment ##

### Stage 1 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The camera controller stays centered on the vessel the whole time, as well as a 5x5 unit cross being drawn in the center. The code follows the all of the basic criteria of using immediate mesh in draw_logic, is binded to the vessel, extends the camera controller class, and being added to the camera array.
___
### Stage 2 ###

- [ ] Perfect
- [ ] Great
- [X] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
This part also followed the basic criteria, and implements a horizontal auto-scrolling box. Checking the code and playing the game itself showed that there wasnt any boundary problems with the vessel staying insde the box the whole time.

 The one major flaw I saw while playing, is that it seems the push from the left corner isn't implemented. Checking the code, there seem to be no lines on the push, only for the horizontal box boundary.

___
### Stage 3 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Stage meets the basic criteria, also correctly sets the required exported fields in the code. Leash distance set in the code makes sure that the vessel never leaves the screen. Camera follows the vessel at a speed slower than, and in the code implements this using the targets velocity * follow_speed * delta. The code also uses the lerp function to snap back to the player.

___
### Stage 4 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Basic criteria met, exported fields are in the code. Like stage three leash distance is kept, and the code is modified to have the center cross lead instead of the vessel, they do this by simply removining the old global position declatation of the camera in their leash loops checks. The new timer is also set and in while playing, you can visibly see the delay wait for the 0.2 seconds set.

___
### Stage 5 ###

- [x ] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Basic criteria met, exported fields in the code. Push zone is developed at two boxed, one inner and one outer. As intended, the camera stoped when the vessel in the inner box and starts moving again when it is in between the inner and outer box, checking the code, I saw the successful speed-up checking for when the vessel touches the edges of the box using a for loop check for each left, right, top, bottom edge.
___
# Code Style #


### Description ###

Overall, the code follows the style guide very well. Proper use of pascal case for their respective methods, as well as neat indentations between blocks of code for better readability. There was one case I saw where there was a line of code with a variable of the same name declared twice, as well as some lines being over 100 column spaces.

#### Style Guide Infractions ####
https://github.com/ensemble-ai/exercise-2-camera-control-ScorpionXiao/blob/f0639dda0648162ea37440efbfdc72f59c865732/Obscura/scripts/camera_controllers/target_focus_lerp_smoothing.gd#L22 - it is considered bad practice to have lines over 100 characters

Doubly delcared variable:

https://github.com/ensemble-ai/exercise-2-camera-control-ScorpionXiao/blob/f0639dda0648162ea37440efbfdc72f59c865732/Obscura/scripts/camera_controllers/speedup_push_zone.gd#L48 

https://github.com/ensemble-ai/exercise-2-camera-control-ScorpionXiao/blob/f0639dda0648162ea37440efbfdc72f59c865732/Obscura/scripts/camera_controllers/speedup_push_zone.gd#L27 

#### Style Guide Exemplars ####
https://github.com/ensemble-ai/exercise-2-camera-control-ScorpionXiao/blob/f0639dda0648162ea37440efbfdc72f59c865732/Obscura/scripts/camera_controllers/speedup_push_zone.gd#L1 - proper use of pascal case

https://github.com/ensemble-ai/exercise-2-camera-control-ScorpionXiao/blob/f0639dda0648162ea37440efbfdc72f59c865732/Obscura/scripts/camera_controllers/speedup_push_zone.gd#L4 - export variables being declared at the top

___
#### Put style guide infractures ####

___

# Best Practices #
Overall, the code was maintained to be very neat, and even followed the same structure as the example code for the first camera method given. I thought the variable names were well thought out, and those that had to be shortened because they were somewhat long, were explained at the top. And I personally thought you had creative solutions to making your code neat that I hadn't even thought of when I did this assignment.

### Description ###

If the student has followed best practices then feel free to point at these code segments as examplars. 

If the student has breached the best practices and has done something that should be noted, please add the infraction.


This should be similar to the Code Style justification.

#### Best Practices Infractions ####
https://github.com/ensemble-ai/exercise-2-camera-control-ScorpionXiao/blob/f0639dda0648162ea37440efbfdc72f59c865732/Obscura/scripts/camera_controllers/speedup_push_zone.gd#L29 - as someone who didn't get to stage 5, i thought more comments like in a block like this, would've been a bit more helpful explaining why some methods like abs() were used here 

#### Best Practices Exemplars ####
https://github.com/ensemble-ai/exercise-2-camera-control-ScorpionXiao/blob/f0639dda0648162ea37440efbfdc72f59c865732/Obscura/scripts/camera_controllers/speedup_push_zone.gd#L37 - i thought you're naming conventions were very thourough, so even though I was confused on why some methods were called upon, the logic itself was easy to follow in terms of what was happening to the camera on a basic level

https://github.com/ensemble-ai/exercise-2-camera-control-ScorpionXiao/blob/f0639dda0648162ea37440efbfdc72f59c865732/Obscura/scripts/camera_controllers/speedup_push_zone.gd#L48 - I really liked that the whole moveset for the vessel moving in any direction was condensed into one variable for movement, it made the code a lot neater and shortened code where specific movements didn't matter.
