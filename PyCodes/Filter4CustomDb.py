fastaDbFile= 'data/taxa/UNITE_public_all_29.11.2022.fasta'
desired_group="Fungi"
filtered_sequences = []
rest_sequences=[]
i = 1

with open(fastaDbFile, "r") as fasta_file:
    current_sequence = ""
    current_header = ""

    for line in fasta_file:
        line = line.strip()
        # if i == 10:
        #     break
        # 
        if line.startswith(">"):  # Header line
            # Process the previous sequence
            if current_header and current_sequence:
                # Check if the current sequence belongs to the desired group
                if desired_group in current_header:
                    filtered_sequences.append((current_header, current_sequence))
                else:
                    rest_sequences.append((current_header, current_sequence))

            current_header = line[1:]  # Remove ">"
            current_sequence = ""
        else:
            current_sequence += line

    # Process the last sequence in the file
    if current_header and current_sequence:
        if desired_group in current_header:
            filtered_sequences.append((current_header, current_sequence))
        # i += 1

# Create a new FASTA file with filtered sequences
output_file = f"data/taxa/{desired_group}.fasta"
output_file_forTheRest=f"data/taxa/without_{desired_group}.fasta"

with open(output_file, "w") as fasta_output:
    for header, sequence in filtered_sequences:
        fasta_output.write(f">{header}\n")
        fasta_output.write(f"{sequence}\n")

with open(output_file_forTheRest, "w") as fasta_restOutput:
    for header, sequence in rest_sequences:
        fasta_restOutput.write(f">{header}\n")
        fasta_restOutput.write(f"{sequence}\n")
            

print(f"Filtered sequences are written to {output_file}.")
print(f"The rest of desired sequences are written to {output_file_forTheRest}.")

