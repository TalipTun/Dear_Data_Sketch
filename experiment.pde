String[] rows;  // To store the CSV rows
int[] teaData, coffeeData, juiceData;  // To store Cups of Tea, Coffee, and Juice data
String[] dates;  // To store the dates

void setup() {
  size(1500, 800);  // Keep original canvas size
  
  // Load the CSV file as a plain text file
  String rawData = join(loadStrings("newone1.csv"), "\n");

  // Split the rows by newline
  rows = split(rawData, '\n');
  
  // Initialize the data arrays
  teaData = new int[rows.length - 1];  // One row for the headers
  coffeeData = new int[rows.length - 1];
  juiceData = new int[rows.length - 1];
  dates = new String[rows.length - 1];
  
  // Parse the CSV data
  for (int i = 1; i < rows.length; i++) {
    String[] cols = split(rows[i], ';');  // Split each row by semicolon
    dates[i - 1] = cols[0];  // Store the date
    teaData[i - 1] = int(cols[1]);  // Cups of Tea
    coffeeData[i - 1] = int(cols[2]);  // Cups of Coffee
    juiceData[i - 1] = int(cols[3]);  // Cups of Juice
  }
  
  noLoop();  // Draw the chart only once
}

void draw() {
  background(255);  // Clear the background with white
  int barWidth = 20;  // Original bar width
  int spacing = 48;  // Increased space between bars by 5px
  int startX = 50;  // Starting X position for the first bar
  int startY = height - 100;  // Y position to keep bars from overlapping
  
  // Loop through each day to draw the stacked bars
  for (int i = 0; i < dates.length; i++) {
    // Heights of the stacked segments (Tea, Coffee, Juice) scaled 4 times
    float teaHeight = teaData[i] * 10 * 4;  // 4 times the original height
    float coffeeHeight = coffeeData[i] * 10 * 4;
    float juiceHeight = juiceData[i] * 10 * 4;
    
    // Total height of the stacked bar
    float totalHeight = teaHeight + coffeeHeight + juiceHeight;
    
    // Calculate the position of each bar (moving horizontally)
    float xPos = startX + (i % 30) * spacing;  // Reset X after every 30 bars (adjust for better wrapping)
    float yPos = startY - totalHeight;  // Position at the bottom of the canvas
    
    // Draw the Tea part of the bar
    fill(255, 0, 0);  // Red for Tea
    rect(xPos, yPos, barWidth, teaHeight);
    
    // Draw the Coffee part of the bar
    fill(0, 0, 255);  // Blue for Coffee
    rect(xPos, yPos + teaHeight, barWidth, coffeeHeight);
    
    // Draw the Juice part of the bar
    fill(0, 255, 0);  // Green for Juice
    rect(xPos, yPos + teaHeight + coffeeHeight, barWidth, juiceHeight);
    
    // Add a label for the date, ensuring enough space to avoid overlap
    fill(0);
    textSize(10);  // Original text size
    textAlign(CENTER, TOP);
    if (i % 30 == 0 && i != 0) {
      yPos -= 150;  // Add extra vertical spacing for wrapped bars
    }
    
    // Adjust the y-position for the date label based on the total height
    text(dates[i], xPos + barWidth / 2, yPos - 10);  // Adjust position for the date
  }
  
  // Add axis labels (original text size)
  fill(0);
  textSize(14);  // Original text size
  textAlign(CENTER, BOTTOM);
  text("Days", width / 2, height - 10);
  textAlign(LEFT, CENTER);
  text("Cups", 10, height / 2);
}
