if test $1 = markdown
then
    file_name=~/bin/markdeep/markdeep_show.html
    echo '<meta charset="utf-8">' > ${file_name}
    cat $2 >> ${file_name}
    echo '<style class="fallback">body{visibility:hidden;white-space:pre;font-family:monospace}</style>' >> ${file_name}
    echo '<script src="~/.config/nvim/run/markdeep.min.js" charset="utf-8"></script>' >> ${file_name}
    echo '<script src="https://morgan3d.github.io/markdeep/latest/markdeep.min.js" charset="utf-8"></script>' >> ${file_name}
    echo '<script>window.alreadyProcessedMarkdeep||(document.body.style.visibility="visible")</script>' >> ${file_name}
    google-chrome-stable ${file_name}
elif test -r ./run.sh
then
    zsh ./run.sh
elif test $1 = python
then
    python3 $2
elif test $1 = scheme
then
    chezscheme --script $2
elif test $1 = javascript
then
    node $2
elif test $1 = c
then
    gcc $2 -o "$2.out"
    ./$2.out
elif test $1 = sh
then
    zsh $2
else
    echo "运行指令未定义"
fi
exit
