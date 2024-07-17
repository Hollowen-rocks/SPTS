using System;
using System.Threading;

class TokenCalculator
{
    static void Main(string[] args)
    {
        bool exit = false;

        while (!exit)
        {
            Console.Clear();
            DisplayHeader();

            Console.ForegroundColor = ConsoleColor.Cyan;
            Console.WriteLine("Main Menu:");
            Console.ResetColor();
            Console.WriteLine("1. Calculate Token Time");
            Console.WriteLine("2. Exit");
            Console.ForegroundColor = ConsoleColor.Cyan;
            Console.Write("\nEnter your choice: ");
            Console.ResetColor();
            string? choice = Console.ReadLine(); // Nullable reference

            switch (choice)
            {
                case "1":
                    TokenCalculationMenu();
                    break;
                case "2":
                    exit = true;
                    break;
                default:
                    Console.ForegroundColor = ConsoleColor.Red;
                    Console.WriteLine("\nInvalid choice. Please try again.");
                    Console.ResetColor();
                    Console.WriteLine("Press any key to return to the main menu...");
                    Console.ReadKey();
                    break;
            }
        }
    }

    static void DisplayHeader()
    {
        Console.ForegroundColor = ConsoleColor.Green;
        Console.WriteLine("##############################################");
        Console.WriteLine("#                                            #");
        Console.WriteLine("#              TOKEN CALCULATOR              #");
        Console.WriteLine("#                                            #");
        Console.WriteLine("##############################################\n");
        Console.ResetColor();
    }

    static void TokenCalculationMenu()
    {
        Console.Clear();
        DisplayHeader();

        Console.ForegroundColor = ConsoleColor.Cyan;
        Console.Write("Enter current token amount: ");
        Console.ResetColor();
        string? currentTokensInput = Console.ReadLine(); // Nullable reference
        if (string.IsNullOrEmpty(currentTokensInput))
        {
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine("Invalid input. Current token amount cannot be empty.");
            Console.ResetColor();
            Console.WriteLine("\nPress any key to return to the main menu...");
            Console.ReadKey();
            return;
        }
        if (!long.TryParse(currentTokensInput, out long currentTokens))
        {
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine("Invalid input. Please enter a valid number for current token amount.");
            Console.ResetColor();
            Console.WriteLine("\nPress any key to return to the main menu...");
            Console.ReadKey();
            return;
        }

        Console.ForegroundColor = ConsoleColor.Cyan;
        Console.Write("Enter desired token amount: ");
        Console.ResetColor();
        string? desiredTokensInput = Console.ReadLine(); // Nullable reference
        if (string.IsNullOrEmpty(desiredTokensInput))
        {
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine("Invalid input. Desired token amount cannot be empty.");
            Console.ResetColor();
            Console.WriteLine("\nPress any key to return to the main menu...");
            Console.ReadKey();
            return;
        }
        if (!long.TryParse(desiredTokensInput, out long desiredTokens))
        {
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine("Invalid input. Please enter a valid number for desired token amount.");
            Console.ResetColor();
            Console.WriteLine("\nPress any key to return to the main menu...");
            Console.ReadKey();
            return;
        }

        Console.ForegroundColor = ConsoleColor.Cyan;
        Console.Write("Are you a VIP? (yes/no): ");
        Console.ResetColor();
        string? vipStatus = Console.ReadLine()?.ToLower(); // Nullable reference
        if (vipStatus == null)
        {
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine("Invalid input. VIP status cannot be empty.");
            Console.ResetColor();
            Console.WriteLine("\nPress any key to return to the main menu...");
            Console.ReadKey();
            return;
        }

        bool isVIP = vipStatus == "yes";

        // Initialize variables
        long tokensPerMinute = 5;
        long tokensPerDay = isVIP ? 200 : 100;
        long tokensPerWeek = isVIP ? 18600 : 9300;
        long totalMinutes = 0;

        Console.Clear();
        Console.WriteLine("\nCalculating...");
        ShowLoadingAnimation();

        while (currentTokens < desiredTokens)
        {
            totalMinutes++;

            currentTokens += tokensPerMinute;

            if (totalMinutes % (24 * 60) == 0)
            {
                currentTokens += tokensPerDay;
            }

            if (totalMinutes % (7 * 24 * 60) == 0)
            {
                currentTokens += tokensPerWeek;
            }
        }

        long days = totalMinutes / (24 * 60);
        long hours = (totalMinutes % (24 * 60)) / 60;
        long minutes = totalMinutes % 60;

        Console.Clear();
        Console.ForegroundColor = ConsoleColor.Green;
        Console.WriteLine("\n##############################################");
        Console.WriteLine("#                                            #");
        Console.WriteLine("#                CALCULATION                 #");
        Console.WriteLine("#                                            #");
        Console.WriteLine("##############################################\n");
        Console.ResetColor();
        Console.ForegroundColor = ConsoleColor.Yellow;
        Console.WriteLine($"Time to reach {desiredTokens} tokens:");
        Console.WriteLine($"{days} days, {hours} hours, and {minutes} minutes.");
        Console.ResetColor();
        Console.WriteLine("\nPress any key to return to the main menu...");
        Console.ReadKey();
    }

    static void ShowLoadingAnimation()
    {
        string[] loadingChars = { "/", "-", "\\", "|" };
        for (int i = 0; i < 20; i++)
        {
            Console.Write(loadingChars[i % 4]);
            Thread.Sleep(100);
            Console.Write("\b");
        }
    }
}
