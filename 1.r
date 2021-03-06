library(lpSolve)
f.obj <- c(2,3)
f.con <- matrix(c(2,3,
             2,6),nrow=2,byrow=TRUE)
f.dir <- c("<=",
         "<=")
f.rhs <- c(8,
          18)
opt=lp("max",f.obj,f.con,f.dir,f.rhs,compute.sens=TRUE)
optval=opt$objval
d=opt$duals
print("Duals:")
cat("Raw Material 1:",d[1],"\n")
cat("Raw Material 2:",d[2],"\n")
from=opt$duals.from
to=opt$duals.to
print("Feasibility range:")
cat("Raw Material 1:",from[1],"to",to[1],"\n")
cat("Raw Material 2:",from[2],"to",to[2],"\n")
d[1]=d[1]-0.30
if(f.rhs[1]+4>=from[1] && f.rhs[1]+4<=to[1]){
   newopt=optval+(d[1]*4)
   if(newopt>optval){
    print("Recommended")
    }
   else
    {
     print("Not recommended")
}
}
cat("The most the company should pay per unit of M2 is",d[2])
optrev=optval+5*d[2]
cat("If M2 availability is increased by 5 units, optimum revenue is increased to",optrev)









SENSITIVITY ANALYSIS
------------------------1----------------------
library(lpSolve)
f.obj<-c(2,3)
f.con<-matrix(c(2,3,
		    2,6),nrow=2,byrow=TRUE)
f.dir<-c("<=","<=")
f.rhs<-c(8,18)
optimum<-lp("max",f.obj,f.con,f.dir,f.rhs)
var_solution<-lp("max",f.obj,f.con,f.dir,f.rhs)$solution
opt<-optimum$objval
cat("Optimum value is ",opt)
cat("variables final value is ",var_solution[1],var_solution[2])
dcons<-lp("max",f.obj,f.con,f.dir,f.rhs,compute.sens=TRUE)$duals
cat("Dual values are \n",dcons[1],"\n",dcons[2])

# Duals lower and upper limits
lowerLimit<-lp("max", f.obj, f.con, f.dir, f.rhs, compute.sens=TRUE)$duals.from
upperLimit<-lp("max", f.obj, f.con, f.dir, f.rhs, compute.sens=TRUE)$duals.to

cat("Dual values Limits are :\n",lowerLimit[1]," ",lowerLimit[2])
cat(upperLimit[1]," ",upperLimit[2])

d1<-dcons[1]-.30

if(f.rhs[1]+4>=lowerLimit[1]&&f.rhs[1]+4<=upperLimit[1]){
	newopt=opt+(d1*4);
	if(newopt>opt){
		print("Recommended")
	}
	else{
		print("Not Recommended")
	}
}

#as the dual price of m2 is 0 the optimum will not change.
---------------------------2---------------------------------------------
library(lpSolve)
f.obj<-c(8,5)
f.con<-matrix(c(2,1,
		    1,0,
		    0,1),nrow=3,byrow=TRUE)
f.dir<-c("<=","<=","<=")
f.rhs<-c(400,150,200)
optimum<-lp("max",f.obj,f.con,f.dir,f.rhs)
var_solution<-lp("max",f.obj,f.con,f.dir,f.rhs)$solution
opt<-optimum$objval
cat("Optimum value is ",opt)
cat("variables final value is ",var_solution[1],var_solution[2])

lp("max",f.obj,f.con,f.dir,f.rhs,compute.sens=TRUE)$duals

# Duals lower and upper limits
lp("max", f.obj, f.con, f.dir, f.rhs, compute.sens=TRUE)$duals.from
lp("max", f.obj, f.con, f.dir, f.rhs, compute.sens=TRUE)$duals.to

if(f.rhs[1]-30>=lowerLimit[1]&&f.rhs[1]-30<=upperLimit[1]){
	cat("New optimal:",opt-(30*opt$duals[1])
}
-------------------------------------------------------------------------------
TRANSPORTATION AND ASSIGNMENT
--------------------------------------------------------------------------
--------------------1------------------------------------------
#
# Load "lpSolve" package
library(lpSolve)

# Set up cost matrix
costs <- matrix(c(2,2,2,1,10,8,5,4,7,6,6,8), nrow = 3, byrow=TRUE)

# Set up constraint signs and right-hand sides
row.signs <- rep("<=", 3)
row.rhs <- c(3,7,5)
col.signs <- rep(">=", 4)
col.rhs <- c(4,3,4,4)

# Run
lptrans <- lp.transport(costs, "min", row.signs, row.rhs, col.signs, col.rhs)
lptrans$solution
lptrans$objval

# 2,10,7,2,8,6,2,5,6,1,4,8
-----------------------------------------------2--------------------------------
#
# Load "lpSolve" package
library(lpSolve)

# Set up cost matrix
costs <- matrix(c(464,352,995,513,416,682,654,690,388,867,791,685), nrow = 3)

# Set up constraint signs and right-hand sides
row.signs <- rep("<=", 3)
row.rhs <- c(75,125,100)
col.signs <- rep(">=", 4)
col.rhs <- c(80,65,70,85)

# Run
lptrans <- lp.transport(costs, "min", row.signs, row.rhs, col.signs, col.rhs)
lptrans$solution
lptrans$objval
---------------------------------------3-------------------------------------------
#
# Load "lpSolve" package
library(lpSolve)

# Set up cost matrix
costs <- matrix(c(5,7,6,2,3,5), nrow = 2,byrow=TRUE)

# Set up constraint signs and right-hand sides
row.signs <- rep("<=", 2)
row.rhs <- c(60,40)
col.signs <- rep(">=", 3)
col.rhs <- c(50,30,20)

# Run
lptrans <- lp.transport(costs, "max", row.signs, row.rhs, col.signs, col.rhs)
lptrans$solution
lptrans$objval
-----------------------ASSIGNMENT---------------4-------------------------------------
library(lpSolve)
a <- matrix(c(17,25,31,10,25,16,12,14,11), nrow = 3, byrow = TRUE)
cost.mat <- a
cost.mat
# Run

lpassign <- lp.assign (cost.mat)
lpassign$solution
lpassign$objval
------------------------------------------------5------------------------
library(lpSolve)
a <- matrix(c(10,14,16,13,12,13,15,12,9,12,12,11,14,16,18,16), nrow = 4, byrow = TRUE)
cost.mat <- a
cost.mat
# Run

lpassign <- lp.assign (cost.mat)
lpassign$solution
lpassign$objval
---------------HUNGARIAN----------------6--------------------------------
library(lpSolve)
a <- matrix(c(80,55,45,45,58,35,70,50,70,50,80,65,90,70,40,80), nrow = 4, byrow = TRUE)
cost.mat <- a
cost.mat
# Run

lpassign <- lp.assign (cost.mat)
lpassign$solution
lpassign$objval


