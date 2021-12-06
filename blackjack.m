%% BLACKJACK
% Text based version of Blackjack
% team A
clc
clear

% userInput
x = 5; % x should only = 1,2,9 or 0

% variables, initialize to 0
playerCards = 0;
playerCardTotal = 0;

dealerCards = 0;
dealerCardTotal = 0;

playerWinnings = 10; % each player starts with $10


% deck, only values 1 - 11 count, disregard suit for text based blackjack
deck = (1:11);

% play blackjack until user hits 0 to quit
while x ~= 0
    x = input('Press 9 to play, Press 0 anytime to quit\n');
    clc
    if x == 9
        disp('Welcome to Blackjack!');
        % players cards
        % shuffle and assign 2 random cards to user
        shuffle = randperm(length(deck), 2);
        playerCards = (shuffle);
        fprintf('\nPlayers hand: \n')
        x=1;
        fprintf('%i | ', playerCards(x:end))
        fprintf('\n')
        playerCardTotal = sum(playerCards);
        fprintf('\n')

        % dealers cards
        % shuffle and assign 2 random cards to dealer, hole card = X
        shuffle = randperm(length(deck), 2);
        dealerCards = (shuffle);
        fprintf('Dealers hand: \n')
        % cover position 1 (X), print the rest of dealers cards
        i=2;
        fprintf('X | ')
        fprintf('%i | ' , dealerCards(i:end))
        fprintf('\n')
        dealerCardTotal = sum(dealerCards);

        % display Hit or Stay for player - continue until player stays (2)
        % continue while player is under 21 or decides to 'stay'
        % if playerCardTotal = 21, blackjack, round over, break
        % if playerCardTotal > 21, bust
        while playerCardTotal < 21 || x==2
            % add bust for dealer
            x = input('\nPlayer: Hit(1) or Stay(2)\n');
            % 1 = hit
            if x == 1
                shuffle = randperm(length(deck), 1);
                % if shuffle = 11 && total > 21, shuffle = 1
                % if shuffle = 11 && total =< 21, shuffle = 11
                if shuffle == 11 && shuffle + playerCardTotal > 21
                    fprintf('ace! 11 now 1')
                    shuffle = 1;
                end
                playerCards(end+1) = shuffle;
                fprintf('\nPlayers hand: \n')
                x=1;
                fprintf('%i | ', playerCards(x:end))
                fprintf('\n')
                playerCardTotal = sum(playerCards);


                for j = 1:length(playerCards)
                    if playerCards(j) == 1 && playerCardTotal == 21
                        playerCards(j) = 11;
                        fprintf('1 changed to 11')
                        fprintf('\nPlayers hand: \n')
                        x=1;
                        fprintf('%i | ', playerCards(x:end))
                        fprintf('\n')
                        playerCardTotal = sum(playerCards);
                    elseif playerCards(j) == 11 && playerCardTotal > 21
                        playerCards(j) = 1;
                        fprintf('11 changed to 1')
                        fprintf('\nPlayers hand: \n')
                        x=1;
                        fprintf('%i | ', playerCards(x:end))
                        fprintf('\n')
                        playerCardTotal = sum(playerCards);
                    end
                end

                % lose / break if over 21
                if playerCardTotal > 21 % || dealerCardTotal > 21
                    break
                end

                % 2 = stay
            elseif x==2
                % display player cards
                fprintf('\nPlayers hand: \n')
                x=1;
                fprintf('%i | ', playerCards(x:end))
                fprintf('\n')

                % display full dealer hand
                % dealer must continue to hit until dealerCardTotal >= 17
                while dealerCardTotal < 17
                    shuffle = randperm(length(deck), 1);
                    % if shuffle = 11 && total > 21, shuffle = 1
                    % if shuffle = 11 && total =< 21, shuffle = 11
                    if shuffle == 11 && shuffle + playerCardTotal > 21
                        fprintf('ace! 11 now 1')
                        shuffle = 1;
                    end
                    dealerCards(end+1) = shuffle;
                    fprintf('\nDealers hand: \n')
                    i=1;
                    fprintf('%i | ' , dealerCards(i:end))
                    fprintf('\n')
                    dealerCardTotal = sum(dealerCards);

                    for j = 1:length(dealerCards)
                        if dealerCards(j) == 1 && dealerCardTotal == 21
                            dealerCards(j) = 11;
                            %fprintf('1 changed to 11')
                            fprintf('%i | ' , dealerCards(i:end))
                            fprintf('\n')
                            dealerCardTotal = sum(dealerCards);
                        elseif dealerCards(j) == 11 && dealerCardTotal > 21
                            dealerCards(j) = 1;
                            %fprintf('11 changed to 1')
                            fprintf('%i | ' , dealerCards(i:end))
                            fprintf('\n')
                            dealerCardTotal = sum(dealerCards);
                        end
                    end

                    if dealerCardTotal >= 17
                        break
                    end
                end

                % break out after hands are dealt, keep current totals
                if playerCardTotal >= dealerCardTotal
                    break;
                end

                if playerCardTotal < dealerCardTotal
                    break;
                end

            elseif x == 0
                break;

            end
        end

        % WIN / LOSE SCENARIOS
        % over 21
        % lose - $10
        if playerCardTotal > 21
            fprintf('\nBust! You lose!\n')
            fprintf('Dealer score: %i\n', dealerCardTotal)
            fprintf('Player score: %i\n', playerCardTotal)
            playerWinnings = playerWinnings - 10;
            fprintf('Player Cash: $%i, ', playerWinnings)
            fprintf('\nPlay again?\n')
        end

        % dealer busts
        % win + $10
        if dealerCardTotal > 21
            fprintf('\nDealer Busts! You Win! \n')
            fprintf('Player score: %i\n', playerCardTotal)
            fprintf('Dealer score: %i\n', dealerCardTotal)
            playerWinnings = playerWinnings + 10;
            fprintf('\nPlayer Cash: $%i, ', playerWinnings)
            fprintf('\nPlay again?\n')
        end

        % blackjack
        % win + 15
        if playerCardTotal == 21
            fprintf('\nBlackjack!\n')
            fprintf('Player score: %i\n', playerCardTotal)
            fprintf('Dealer score: %i\n', dealerCardTotal)
            playerWinnings = playerWinnings + 15;
            fprintf('Player Cash: $%i, ', playerWinnings)
            fprintf('\nPlay again?\n')
        end

        % dealer blackjack
        % push
        if dealerCardTotal == 21 && dealerCardTotal > playerCardTotal
            fprintf('\nDealer Blackjack - You lose!\n')
            fprintf('Dealer score: %i\n', dealerCardTotal)
            fprintf('Player score: %i\n', playerCardTotal)
            playerWinnings = playerWinnings - 10;
            fprintf('Player Cash: $%i, ', playerWinnings)
            fprintf('\nPlay again?\n')
        end

        % tie
        % push
        if playerCardTotal == dealerCardTotal
            fprintf('\nTie - Push!\n')
            fprintf('Player score: %i\n', playerCardTotal)
            fprintf('Dealer score: %i\n', dealerCardTotal)
            fprintf('Player Cash: $%i, ', playerWinnings)
            fprintf('\nPlay again?\n')
        end

        % win + 10
        if playerCardTotal > dealerCardTotal && playerCardTotal < 21
            fprintf('\nYou Win!\n')
            fprintf('Player score: %i\n', playerCardTotal)
            fprintf('Dealer score: %i\n', dealerCardTotal)
            playerWinnings = playerWinnings + 10;
            fprintf('Player Cash: $%i, ', playerWinnings)
            fprintf('\nPlay again?\n')
        end

        % loss - 10
        if playerCardTotal < dealerCardTotal && dealerCardTotal < 21
            fprintf('\nYou Lose!\n')
            fprintf('Dealer score: %i\n', dealerCardTotal)
            fprintf('Player score: %i\n', playerCardTotal)
            playerWinnings = playerWinnings - 10;
            fprintf('Player Cash: $%i\n', playerWinnings)
            fprintf('\nPlay again?\n')
        end



    end

    % quit if player hits 0 at any time
    if x == 0
        break
    end
end
disp('Goodbye!')
