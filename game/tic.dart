import 'dart:io';

void main() {
  print('Welcome to Tic-Tac-Toe!\n');

  while (true) {
    playGame();
    print('\nDo you want to play again? (yes/no): ');

    // Check if the player wants to play again
    String playAgain = stdin.readLineSync()?.toLowerCase() ?? '';
    if (playAgain != 'yes') {
      print('\nThanks for playing. Goodbye!');
      break;
    }
  }
}

void playGame() {
  List<String> board = List.filled(9, ' '); // Initialize an empty 3x3 board
  bool playerXTurn = true; // Player 'X' goes first

  while (true) {
    printBoard(board);

    // Determine the current player and marker
    String currentPlayer = playerXTurn ? 'X' : 'O';
    print('\nPlayer $currentPlayer\'s turn. Enter your move (1-9): ');

    // Get and validate user input
    int move = getUserMove(board);
    if (move == -1) {
      print('Invalid move. Please try again.');
      continue;
    }

    // Update the board with the player's move
    board[move - 1] = currentPlayer;

    // Check for a winner or a draw
    if (checkWinner(board, currentPlayer)) {
      printBoard(board);
      print('\nPlayer $currentPlayer wins!');
      break;
    } else if (board.every((cell) => cell != ' ')) {
      printBoard(board);
      print('\nThe game is a draw!');
      break;
    }

    // Switch to the other player for the next turn
    playerXTurn = !playerXTurn;
  }
}

void printBoard(List<String> board) {
  print(' ${board[0]} | ${board[1]} | ${board[2]} ');
  print('-----------');
  print(' ${board[3]} | ${board[4]} | ${board[5]} ');
  print('-----------');
  print(' ${board[6]} | ${board[7]} | ${board[8]} ');
}

int getUserMove(List<String> board) {
  int move;
  try {
    move = int.parse(stdin.readLineSync()?.trim() ?? '');

    // Check if the move is within the valid range and the cell is empty
    if (move < 1 || move > 9 || board[move - 1] != ' ') {
      return -1;
    }
  } catch (e) {
    return -1; // Invalid input
  }
  return move;
}

bool checkWinner(List<String> board, String player) {
  // Check rows, columns, and diagonals for a winning condition
  for (int i = 0; i < 3; i++) {
    if ((board[i * 3] == player && board[i * 3 + 1] == player && board[i * 3 + 2] == player) ||
        (board[i] == player && board[i + 3] == player && board[i + 6] == player)) {
      return true;
    }
  }

  if ((board[0] == player && board[4] == player && board[8] == player) ||
      (board[2] == player && board[4] == player && board[6] == player)) {
    return true;
  }

  return false;
}