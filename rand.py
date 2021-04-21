import random

members = ["Andrew",
           "Arun",
           "Alexis",
           "Ben",
           "Beth",
           "Dunni",
           "Isobel",
           "Jordan",
           "Jose",
           "Oleg",
           "Saverio",
           "William",
           "Ula"
           ]


def split_list(mem_count):
    """ Uses RNG to pick members for each teams """
    team_no = 1
    count = 0
    string = ""
    print("\n")

    for _ in range(0, len(members), 1):
        rand = random.randint(0, len(members) - 1)
        string += members[rand]
        members.pop(rand)
        count += 1
        if count == mem_count:
            print(f"Team {team_no}: {string}")
            string = ""
            count = 0
            team_no += 1
        else:
            string += ", "
    # If teams are uneven in numbers then print the uneven team
    if string:
        print(f"Team {team_no}: {string[:-2]}")


split_list(int(input("Enter the amount of members per group: ")))
input("\nPress any key to exit!")