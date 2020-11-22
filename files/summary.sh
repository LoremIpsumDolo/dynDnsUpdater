#!/bin/bash


TITLE="System Information for $HOSTNAME"
RIGHT_NOW=$(date +"%x %r %Z")
TIME_STAMP="Updated on $RIGHT_NOW by $USER"

function write_page()
{

logs=$(cat ./files/logs.txt)

  cat <<- _EOF_
<html>
<head>
    <title>$TITLE</title>
<style type="text/css">
#table {
  font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 100%;
}
#table td, #table th {
  border: 1px solid #ddd;
  padding: 8px;
  text-align: left;
}
#table tr:nth-child(even){background-color: #f2f2f2;}
#table tr:hover {background-color: #f2f2f2;}
#table th {
    height: 30px;
    padding-top: 10px;
    padding-bottom: 10px;
    text-align: left;
    background-color: #f2f2f2;
    color: black;
}
</style>
  </head>
  <body>
      <h1>$TITLE</h1>
      <p>$TIME_STAMP</p>
      <table id="table">
        <tr>
          <th>Datum</th>
          <th>IP</th>
        </tr>
        <tr>
        $logs
        </tr>
      </table>
  </body>
  </html>
_EOF_

}
