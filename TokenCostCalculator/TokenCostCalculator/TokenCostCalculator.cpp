#include <iostream>
#include <vector>
#include <stdexcept>
#include <chrono>
#include <limits>
#include <cstdint>

using namespace std;

struct TokenPackage {
    int64_t tokens;
    int64_t robux;
};

const TokenPackage packages[] = {
    {60000, 5000}
};

int64_t calculateRobux(int64_t tokensRequired) {
    int64_t totalRobux = 0;
    int64_t remainingTokens = tokensRequired;

    for (const auto& package : packages) {
        while (remainingTokens >= package.tokens) {
            remainingTokens -= package.tokens;
            totalRobux += package.robux;
        }
    }

    if (remainingTokens > 0) {
        totalRobux += 400; 
    }

    return totalRobux;
}

void validateTokenInput(int64_t tokens) {
    if (tokens < 0) {
        throw invalid_argument("Token values cannot be negative.");
    }
    if (tokens % 5 != 0) {
        throw invalid_argument("Tokens must end in 0 or 5.");
    }
}

void clearInputStream() {
    cin.clear();
    cin.ignore(numeric_limits<streamsize>::max(), '\n');
}

void clearScreen() {
    cout << "\033[2J\033[1;1H";
}

int main() {
    try {
        while (true) {
            int64_t currentTokens, desiredTokens;
            cout << "\033[1;32mEnter your current tokens: \033[0m";
            cin >> currentTokens;

            if (!cin) {
                clearInputStream();
                cerr << "\033[1;31mInvalid input. Please enter a valid number.\033[0m" << endl;
                continue;
            }

            try {
                validateTokenInput(currentTokens);
            }
            catch (const invalid_argument& e) {
                cerr << "\033[1;31mInvalid argument: \033[0m" << e.what() << endl;
                continue;
            }

            cout << "\033[1;32mEnter your desired tokens: \033[0m";
            cin >> desiredTokens;

            if (!cin) {
                clearInputStream();
                cerr << "\033[1;31mInvalid input. Please enter a valid number.\033[0m" << endl;
                continue;
            }

            try {
                validateTokenInput(desiredTokens);
            }
            catch (const invalid_argument& e) {
                cerr << "\033[1;31mInvalid argument: \033[0m" << e.what() << endl;
                continue;
            }

            int64_t tokensNeeded = desiredTokens - currentTokens;
            if (tokensNeeded <= 0) {
                cout << "\033[1;33mYou already have enough tokens.\033[0m" << endl;
                continue;
            }

            auto start = chrono::high_resolution_clock::now();

            int64_t totalRobuxNeeded = calculateRobux(tokensNeeded);

            auto end = chrono::high_resolution_clock::now();
            chrono::duration<double> elapsed = end - start;

            cout << "\033[1;34mYou need " << totalRobuxNeeded << " Robux to reach your desired tokens NOT including VIP status (Which is +400 Robux).\033[0m" << endl;
            cout << "\033[1;36mCalculation completed in " << elapsed.count() << " seconds.\033[0m" << endl;

            char continueChoice;
            cout << "\033[1;32mDo you want to perform another calculation? (y/n): \033[0m";
            cin >> continueChoice;
            if (continueChoice != 'y' && continueChoice != 'Y') {
                break;
            }

            clearScreen();
        }
    }
    catch (const invalid_argument& e) {
        cerr << "\033[1;31mInvalid argument: \033[0m" << e.what() << endl;
    }
    catch (const exception& e) {
        cerr << "\033[1;31mException: \033{0m" << e.what() << endl;
    }
    catch (...) {
        cerr << "\033[1;31mUnknown error occurred.\033[0m" << endl;
    }

    return 0;
}
