#!/bin/bash
folderName=$1
executable=$2

returnValue=0
compilationTest="PASS"
valgrindTest="PASS"
helgrindTest="PASS"

cd $folderName

make > /dev/null 2>&1

if [ $? -ne 0 ]
then

echo "          Compilation           Memory leaks            Thread race"
echo      "	   " 		  " FAIL"     "	   	   "  	  "FAIL"     	"		   "	    "FAIL"
echo "Return value is : " $returnValue

        exit 7  
fi

valgrind --tool=memcheck --leak-check=full --error-exitcode=1 ./$executable > /dev/null  2>&1
 succesfullmake=$?  

if [ $succesfullmake -ne 0 ]
then
        valgrindTest="FAIL"
        ((returnValue=$returnValue+2))   # In binary value : 010 when valgrind test was failed

fi

valgrind --tool=helgrind --error-exitcode=1 ./$executable > /dev/null  2>&1
succesfullmake=$?

if [ $succesfullmake -ne 0 ]
then
        helgrindTest="FAIL"
        ((returnValue=$returnValue+1))   # In binary value : 001 when helgrind test was failed

fi

echo "   "
echo "          Compilation           Memory leaks            Thread race"
echo "             " $compilationTest"       	     "$valgrindTest"     		     "$helgrindTest

echo "  "
echo "Return value is : " $returnValue

exit $returnValue
