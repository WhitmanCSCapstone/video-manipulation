# File to translate .pde sketch files to quad objects
# ready for our program.

#TODO Make indent and write into one method. fix comments update typing
# Address indexing in other functions
# Global functions
 
# Cleanup infile
# Reorganize the file 

import sys
import re

#https://stackoverflow.com/questions/68633/regex-that-will-match-a-java-method-declaration
func = re.compile(r'^[ \t]*(?:(?:public|protected|private)\s+)?(?:(static|final|native|synchronized|abstract|threadsafe|transient|(?:<[?\w\[\] ,&]+>)|(?:<[^<]*<[?\w\[\] ,&]+>[^>]*>)|(?:<[^<]*<[^<]*<[?\w\[\] ,&]+>[^>]*>[^>]*>))\s+){0,}(?!return)\b([\w.]+)\b(?:|(?:<[?\w\[\] ,&]+>)|(?:<[^<]*<[?\w\[\] ,&]+>[^>]*>)|(?:<[^<]*<[^<]*<[?\w\[\] ,&]+>[^>]*>[^>]*>))((?:\[\]){0,})\s+\b\w+\b\s*\(\s*(?:\b([\w.]+)\b(?:|(?:<[?\w\[\] ,&]+>)|(?:<[^<]*<[?\w\[\] ,&]+>[^>]*>)|(?:<[^<]*<[^<]*<[?\w\[\] ,&]+>[^>]*>[^>]*>))((?:\[\]){0,})(\.\.\.)?\s+(\w+)\b(?![>\[])\s*(?:,\s+\b([\w.]+)\b(?:|(?:<[?\w\[\] ,&]+>)|(?:<[^<]*<[?\w\[\] ,&]+>[^>]*>)|(?:<[^<]*<[^<]*<[?\w\[\] ,&]+>[^>]*>[^>]*>))((?:\[\]){0,})(\.\.\.)?\s+(\w+)\b(?![>\[])\s*){0,})?\s*\)(?:\s*throws [\w.]+(\s*,\s*[\w.]+))?')
midiInput = re.compile(r'(cc)')
javaPrimitives = {"byte", "short", "int", "long", "float", "double", "char", "boolean"}
processingAdditions = {"PImage","PVector","Capture","Movie","String","PFont","PApplet","PGraphics"}
typesToIgnore = {"Midi"}

#Read input file to string
infile = ""
with open("D:\\Programming\\video-manipulation1\\InputConfiguration\\tempClass.pde","r") as f:
    infile = f.read()
infile = infile.split("\n")

def findMidiInput(string):
    m = midiInput.search(string)
    return m

def writeGlobalComments(f):
    """
        Currently just writes the comments until code is reached.
        Totally might break.
    """
    inBody = False
    for line in infile:
        if line.startswith("/*"):
            f.write(line + "\n")
            if "*/" not in line:
                inBody = True
            continue
        if "*/" in line:
            f.write(line + "\n")
            inBody = False
        if inBody:
            f.write(line + "\n")
        elif len(removeComments(line)) > 1:
            f.write("\n")
            return
        else:
            f.write(line + "\n")
    
def containsFunction(string):
    m = func.search(string)
    return m

def removeComments(string):
    lineComment = string.find("//")
    if lineComment != -1:
        string = string[:lineComment]
    while "/*" in string:
        sindex = string.find("/*")
        eindex = string.find("*/")
        if sindex < eindex:
            string = string[:sindex] + string[eindex+2:]
        else:
            break
    return string

indentLevel = 0
def indent():
    global indentLevel
    return "\t" * indentLevel

def writeImports(f):
    toImport = []
    for line in infile:
        if line.startswith("import"):
            toImport.append(line)
    if len(toImport) > 0:
        f.write("//IMPORTS FOLLOW - Double check to make sure these are necessary!\n")
        for imp in toImport:
            f.write(imp + "\n")
        f.write("\n")
    

def writeGlobalFunctions(f):
    inFunction = False
    scopeDepth = 0
    for line in infile:
        noComments = removeComments(line)
        if "{" in noComments:
            scopeDepth += 1
        if "}" in noComments:
            scopeDepth -= 1
        if not inFunction and (scopeDepth == 0 or (scopeDepth == 1 and "{" in noComments)):
            if containsFunction(noComments):
                if not( "void setup()" in noComments or "void draw()" in noComments or "void controllerChang" in noComments):
                    inFunction = True
                    f.write("\tprivate " + line + "\n")
        elif inFunction:
            if scopeDepth == 0: #Found a }
                f.write("\t" + line + "\n")
                f.write("\n")
                inFunction = False
            else:
                f.write("\t" + line + "\n")

def writeClass(f):
    global indentLevel
    f.write("public class OutputQuad extends QuadObject{\n")
    indentLevel += 1
    writeFields(f)
    writeConstructor(f)
    writeRunSketch(f)
    indentLevel -= 1
    writeGlobalFunctions(f)
    f.write("}\n")

def writeFields(f):
    allGlobals = findGlobals()
    for globalVariable in allGlobals:
        line = globalVariable[0] + " " +  " ".join(globalVariable[1])
        f.write(indent() + "private " + line + "\n")
    f.write("\n")

def getSetup():
    setupStartIndex = -1
    setupEndIndex = -1
    setupLines = []
    inSetup = False
    scopeDepth = 0
    for i,line in enumerate(infile):
        #Remove comments
        if "void setup()" in removeComments(line[:]):
            setupStartIndex = i+1
            inSetup = True
            continue
        if "{" in removeComments(line[:]):
            scopeDepth += 1
        if "}" in removeComments(line[:]):
            scopeDepth -= 1
        if scopeDepth < 0:
            inSetup = False
            setupEndIndex = i
            break
        if inSetup:
            setupLines.append(line)
    return setupLines
        
def writeConstructor(f):
    f.write(indent() + "OutputQuad(PApplet app, PGraphics buffer){\n")
    constructorBody = getSetup()
    for line in constructorBody:
        f.write(indent() + line + "\n")
    f.write(indent() + "}\n")
    f.write("\n")

def getDraw():
    drawStartIndex = -1
    drawEndIndex = -1
    drawLines = []
    inDraw = False
    scopeDepth = 0
    for i,line in enumerate(infile):
        #Remove comments
        #print(line)
        if "void draw()" in removeComments(line[:]):
            drawStartIndex = i+1
            inDraw = True
            continue
        if "{" in removeComments(line[:]):
            scopeDepth += 1
        if "}" in removeComments(line[:]):
            scopeDepth -= 1
        if scopeDepth < 0:
            inDraw = False
            drawEndIndex = i
            break
        if inDraw:
            drawLines.append(line)
            #print(line)
    return drawLines

def writeRunSketch(f):
    global indentLevel
    f.write(indent() + "@Override\n")
    f.write(indent() + "protected void runSketch(Arraylist<Float> params){\n")
    indentLevel += 1
    f.write(indent() + "tempBuffer.beginDraw()\n")
    runSketchBody = getDraw()
    #Address indenting
    for line in runSketchBody:
        f.write("\t" + line + "\n")
    f.write(indent() + "tempBuffer.endDraw();\n")
    indentLevel -= 1
    f.write(indent() + "}\n")
    f.write("\n")

    
# print(infile)
def findGlobals():
    scope = 0
    globalsToAdd = []
    for line in infile:
        noComments = removeComments(line)
        if "\{" in noComments:
            scope += 1
        if "\}" in noComments:
            scope -= 1
        #Get all possible keywords/separate Midi and global structs
        if noComments.startswith(tuple(javaPrimitives.union(processingAdditions))) and scope == 0 and not containsFunction(noComments):
            #if not noComments.startswith(tuple(typesToIgnore)):
            if not "cc" in noComments:
                globalsToAdd.append((line.split()[0],  line.split()[1:]))
    return globalsToAdd

def replaceCC(IRFile):
    with open("output.pde","w") as f:
        for line in IRFile:
            if findMidiInput(line):
                startIndex = line.find("cc")
                rParen = line[startIndex:].find("]")
                indexIn = line[startIndex+3:rParen+startIndex]
                composite = line[:startIndex] + "params.get(" + indexIn + ")" + line[rParen + startIndex + 1:]
                f.write(composite + " // Warning - Midi Line" + "\n")
            else:
                f.write(line + '\n')


def generateNewFile():
    with open("output.pde","w+") as f:
        writeGlobalComments(f)
        writeImports(f)
        writeClass(f)
    
    #Second pass to replace Midi cc array
    #Totally could have used truncate
    with open("output.pde","r+") as f:
        IRFile = f.read()
        IRFile = IRFile.split("\n")
        replaceCC(IRFile)
        

generateNewFile()