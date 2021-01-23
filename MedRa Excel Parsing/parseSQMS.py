def writeChild(file,parents,line):
    line = line.strip().replace("\t","$$")
    for i in range(0,len(parents)):
        file.write(parents[i][0])
        if i < len(parents)-1:
            file.write("|")
    file.write("$$"+line+"\n")


def getNumberOfTabes(line):
    cnt = 0
    for i in line:
        if i == '\t':
            cnt+=1
        else:
            break
    return cnt

def IsDetails(line):
    if "narrow" in line.strip().lower() or "broad" in line.strip().lower():
        return True
    return False


# SMQ_22_1.txt is just copy of the excel after expanding it to the lowest level by copy and paste in text file.
file1 = open("SMQ_22_1.txt","r")
filedetail = open("childdetail_SMQ_22_1.txt","w")

parents = []
while True:
    line = file1.readline()
    if not line:
        break
    num=getNumberOfTabes(line)

    if IsDetails(line):
        writeChild(filedetail,parents,line)
    else:
        if num == 0:
            parents=[]
            parents.append((line.strip(),num))

        else:
            while num <= parents[len(parents)-1][1]:
                parents.pop()
            parents.append((line.strip(), num))





file1.close()
filedetail.close()
