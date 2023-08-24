Access complete cheatsheet donw below<br>
https://htmlpreview.github.io/?https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/blob/main/src/solution_syntax/solution_syntax.html

<img width="686" alt="GitImage" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/59209a39-7f93-4905-8c16-bd28688d0626">

# ABAP memory
You may use BUFFER or INTERNAL TABLE to exchange ABAP memory but former is much simpler to use. BUFFER transfers to cluster data the buffer data object which is in xstring format.
The main difference is that passing data using MEMORY ID is not supported anymore. Therefore only these 2 options are available.

Find demo program for ABAP Memory [here](..blob/main/src/zabap_memory.clas.abap)
