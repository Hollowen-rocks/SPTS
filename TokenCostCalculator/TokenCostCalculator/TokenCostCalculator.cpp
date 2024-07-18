// if you skid this at least put my git in here :(

#include <iostream>
#include <vector>
#include <thread>
#include <future>
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
    {60000, 5000},
    {28000, 3200},
    {12000, 1600},
    {5200, 800},
    {2200, 400},
    {400, 100}
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

void calculateInThread(int64_t tokensRequired, promise<int64_t>&& resultPromise) {
    try {
        int64_t result = calculateRobux(tokensRequired);
        resultPromise.set_value(result);
    }
    catch (...) {
        resultPromise.set_exception(current_exception());
    }
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

// Main function
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

            const int numThreads = 70;
            vector<promise<int64_t>> promises(numThreads);
            vector<future<int64_t>> futures;
            for (int i = 0; i < numThreads; ++i) {
                futures.push_back(promises[i].get_future());
            }

            int64_t tokensPerThread = tokensNeeded / numThreads;
            vector<thread> threads;
            for (int i = 0; i < numThreads; ++i) {
                int64_t startTokens = tokensPerThread * i;
                int64_t endTokens = (i == numThreads - 1) ? tokensNeeded : tokensPerThread * (i + 1);
                int64_t tokensForThread = endTokens - startTokens;
                threads.push_back(thread(calculateInThread, tokensForThread, move(promises[i])));
            }

            int64_t totalRobuxNeeded = 0;
            for (auto& future : futures) {
                totalRobuxNeeded += future.get();
            }
            for (auto& th : threads) {
                th.join();
            }

            totalRobuxNeeded += 400;

            auto end = chrono::high_resolution_clock::now();
            chrono::duration<double> elapsed = end - start;

            cout << "\033[1;34mYou need " << totalRobuxNeeded << " Robux to reach your desired tokens including VIP status (+400 Robux).\033[0m" << endl;
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
        cerr << "\033[1;31mException: \033[0m" << e.what() << endl;
    }
    catch (...) {
        cerr << "\033[1;31mUnknown error occurred.\033[0m" << endl;
    }

    return 0;
}
