import sys
nvme_lines = []
with open(sys.argv[1], 'r') as file:
    while True:
        line = file.readline()
        if line == "":
            break
        parts = line.split()
        if line[1] == '─' and len(parts) < 7:
            nvme_lines.append(parts[0][2:])
with open(sys.argv[2], 'a') as file:
    for line in nvme_lines:
        file.write(f"{line}\n")

