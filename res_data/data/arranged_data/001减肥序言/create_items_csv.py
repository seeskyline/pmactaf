# lizk
# coding=utf-8


import stat
import os
import os.path
import string


def fileLine(filename, directoryName):
    creatTime = os.stat(filename)[stat.ST_MTIME]
    
    title = filename[9:]
    refCategoryID = -1;
    refCategoryIDStr = directoryName[0:3] 
    print "%s" %(directoryName)       
#if refCategoryIDStr.isdigit() == False:
 #       refCategoryID = string.atoi(refCategoryIDStr);
        
    line = "%s|data/%s|0|0|%s|%s|%d\n" % (title, filename, creatTime, creatTime, refCategoryID)
    return (creatTime, line)


def ls_cmp(s1, s2):
    return cmp(s1[0], s2[0])


def visit(args, directoryName, filesInDirectory):
    ls = args
    for filename in filesInDirectory:
        # ignore hidden files & python/csv files
        if filename.startswith(".") == True \
                or filename.endswith(".py") == True \
                or filename.endswith(".css") == True \
                or filename.endswith(".csv") == True: 
            continue
            
        s = fileLine(filename, directoryName)
        ls.append(s)


def main():
    print os.getcwd()
    ls = []
    os.path.walk(".", visit, ls)
    ls.sort(ls_cmp)
    f = open("items.csv", "w")
    for s in ls:
        f.write(s[1])
    f.close()


if __name__ == "__main__":
    main()
