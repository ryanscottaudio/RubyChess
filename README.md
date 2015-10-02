# RubyChess

A chess game for two players written entirely in Ruby and playable in the terminal.

On your turn, use the arrow keys to move the cursor around the board; using the space bar or the enter/return key, select first the piece you'd like to move, and then the space to which you'd like to move it. This will pass play to the next player; the game will continue until one player has checkmated the other.

In order to DRY up my code, I included two classes, SlidingPiece and SteppingPiece, which define the two basic categories that most chess pieces fall into; the individual classes for each piece only include their movement patterns and the characters that should represent them on the board.

In the future, I hope to add more obscure chess moves, such as _en passant_ and castling, and an optional timer for speed chess.
