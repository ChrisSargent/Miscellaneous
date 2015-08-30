import os
def renamefiles():
    #Get file names from folder
    filelist = os.listdir("/Users/chrissargent/Downloads/prank")

    #Change working directory
    savedpath = os.getcwd()
    os.chdir("/Users/chrissargent/Downloads/prank")
    
    #Strip numbers from filenames
    for filename in filelist:
        newfilename = filename.translate(None,"0123456789")
        os.rename(filename, newfilename)
        print("Old Name - " +filename)
        print("New Name - " +newfilename)
    #Change back to original working directory
    os.chdir(savedpath)

renamefiles()
