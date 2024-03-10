import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
p1="/content/drive/MyDrive/Dataset/Batting_summary.csv"
p2="/content/drive/MyDrive/Dataset/Bowling_Summary.csv"
p3="/content/drive/MyDrive/Dataset/Players.csv"
p4="/content/drive/MyDrive/Dataset/MATCH SUMMARY.csv"

bat = pd.read_csv(p1)
bowl=pd.read_csv(p2)
player=pd.read_csv(p3)
mat=pd.read_csv(p4)
print(bat.head())

total_runs=bat["runs"].sum()
print(total_runs)

top10_scorer = bat.groupby(by="batsmanName")['runs'].sum().nlargest(10).reset_index()
print(top10_scorer)

import matplotlib.pyplot as plt

# Create a bar chart of the top 10 scorers
plt.bar(top10_scorer["batsmanName"], top10_scorer["runs"])

# Set the title and labels
plt.title("Top 10 Scorers")
plt.xlabel("Batsman Name")
plt.ylabel("Runs Scored")

# Rotate the x-axis labels
plt.xticks(rotation=45)

# Display the plot
plt.show()

total_4s=bat['4s'].sum()
print(total_4s)

top10_4s_getter=bat.groupby(by='batsmanName')['4s'].sum().nlargest(10).reset_index()
top10_6s_getter=bat.groupby(by='batsmanName')['6s'].sum().nlargest(10).reset_index()

print(top10_4s_getter)
print(top10_6s_getter)


top10_4s_getter=bat.groupby(by='battingPos')['4s'].sum().nlargest(10).reset_index()
top10_6s_getter=bat.groupby(by='batsmanName')['6s'].sum().nlargest(10).reset_index()
print(top10_4s_getter)

import matplotlib.pyplot as plt
plt.bar(top10_4s_getter["battingPos"], top10_4s_getter["4s"])

# Set the title and labels
plt.title("top_4sgetter")
plt.xlabel("position")
plt.ylabel("4s")
