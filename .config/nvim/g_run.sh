cd $1
if test $2 = markdown
then
    file_name=~/bin/markdeep/markdeep_show.html
    echo '<meta charset="utf-8">' > ${file_name}
    cat $3 >> ${file_name}
    echo '<style class="fallback">body{visibility:hidden;white-space:pre;font-family:monospace}</style>' >> ${file_name}
    echo '<script src="~/.config/nvim/run/markdeep.min.js" charset="utf-8"></script>' >> ${file_name}
    echo '<script src="https://morgan3d.github.io/markdeep/latest/markdeep.min.js" charset="utf-8"></script>' >> ${file_name}
    echo '<script>window.alreadyProcessedMarkdeep||(document.body.style.visibility="visible")</script>' >> ${file_name}
    google-chrome-stable ${file_name}
elif test -r ./run.sh
then
    zsh ./run.sh
elif test $2 = python
then
    python3 $3
elif test $2 = scheme
then
    chezscheme --script $3
elif test $2 = javascript
then
    node $3
elif test $2 = c
then
    gcc $3 -o "$3.out"
    ./$3.out
elif test $2 = sh
then
    zsh $3
elif test $2 = html
then
    google-chrome-stable $3
else
    echo "运行指令未定义"
fi
exit
