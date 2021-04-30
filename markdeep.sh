file_name=~/bin/markdeep/a.html
echo '<meta charset="utf-8">' > ${file_name}
cat $1 >> ${file_name}
echo '<style class="fallback">body{visibility:hidden;white-space:pre;font-family:monospace}</style>' >> ${file_name}
echo '<script src="~/bin/markdeep/markdeep.min.js" charset="utf-8"></script>' >> ${file_name}
echo '<script src="https://morgan3d.github.io/markdeep/latest/markdeep.min.js" charset="utf-8"></script>' >> ${file_name}
echo '<script>window.alreadyProcessedMarkdeep||(document.body.style.visibility="visible")</script>' >> ${file_name}
google-chrome ${file_name}
