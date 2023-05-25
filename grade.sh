set -e

CPATH='.;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission


cd student-submission

if [[ -f ListExamples.java ]]
then
    echo "File exists"
else
    echo "File does not exist"
    exit
fi

echo 'Finished cloning'

cp ListExamples.java ../grading-area
cd ..
cp *.java ./grading-area
cp -r lib ./grading-area
cd grading-area

set +e

javac -cp $CPATH ListExamples.java TestListExamples.java >compile-output.txt 2>&1
if [[ $? -eq 0 ]]
then
    echo "Code compiles"
else
    echo "Code does not compile"
fi

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples >run-output.txt 2>&1

err_code=$?

if [[ $err_code -eq 0 ]]
then
    echo "Tests all passed!"
else
    echo "Some tests didn't pass. Student submission has errors!"
fi

# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
