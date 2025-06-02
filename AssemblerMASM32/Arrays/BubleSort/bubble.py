import pygame
import time
import random

# To Install Pygame use a command: pip install pygame
# Initialize Pygame
pygame.init()

# Constants
WIDTH, HEIGHT = 640, 480
BLACK = (0, 0, 0)
WHITE = (255, 255, 255)
BLUE = (0, 0, 255)
RED = (255, 0, 0)
GRAY = (192, 192, 192)
FONT_SIZE = 20
BLOCK_SIZE = 50
ARRAY = [4, 3, 2, 1]#[64, 34, 25, 12, 22, 11, 90]
# Calculate starting x position to center the array
start_x = (WIDTH - (len(ARRAY) * (BLOCK_SIZE + 10) - 10)) // 2
start_y = 40  # Initial y position for the first row

# Screen setup
screen = pygame.display.set_mode((WIDTH, HEIGHT))
pygame.display.set_caption("Bubble Sort Visualization")
#font = pygame.font.Font(None, FONT_SIZE)
font = pygame.font.SysFont("arial", FONT_SIZE)

def draw_complexity_message():
    message = "Bubble Sort O(n²)"
    text = font.render(message, True, BLACK)
    screen.blit(text, (WIDTH // 2 - text.get_width() // 2, 10))

def flicker_effect(array, row, positions):
    times = 2  # Number of flickers
    delay = 0.5  # Delay between flickers
    for _ in range(times):
        # Draw with flicker color
        draw_array(array, row, highlighted=positions, flicker=True)
        time.sleep(delay)
        # Draw normal
        draw_array(array, row, highlighted=positions, flicker=False)
        time.sleep(delay)

def draw_array(array, row, highlighted=None, flicker=False):
    offset_y = start_y + row * (BLOCK_SIZE + 20)
    for i, value in enumerate(array):
        x = start_x + i * (BLOCK_SIZE + 10)
        y = offset_y
        color = RED if flicker and i in highlighted else BLUE

        pygame.draw.rect(screen, WHITE, (x, y, BLOCK_SIZE, BLOCK_SIZE))
        pygame.draw.rect(screen, color, (x, y, BLOCK_SIZE, BLOCK_SIZE), 3)  # Blue border
        text = font.render(str(value), True, (0, 0, 0))
        text_rect = text.get_rect(center=(x + BLOCK_SIZE // 2, y + BLOCK_SIZE // 2))
        screen.blit(text, text_rect)
    pygame.display.flip()

def bubble_sort(array):
    n = len(array)
    operations = 0
    for i in range(n):
        already_sorted = True
        #operations += 1
        for j in range(n - i - 1):
            operations += 1
            draw_array(array, i, highlighted=[j, j + 1])
            time.sleep(1.0)  # Slow down the algorithm for visualization
            if array[j] > array[j + 1]:
                operations += 1
                flicker_effect(array, i, [j, j + 1])
                array[j], array[j + 1] = array[j + 1], array[j]
                already_sorted = False
                draw_array(array, i, highlighted=[j, j + 1])
                time.sleep(1.0)  # Slow down the algorithm for visualization
        if already_sorted:
            break
    return operations

# Main loop
running = True
sorting_started = False
operations = 0
screen.fill(GRAY)  # Clear screen for sorting visualization

while running:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False
        if event.type == pygame.KEYDOWN:
            if event.key == pygame.K_RETURN and not operations:
                sorting_started = True
            if event.key == pygame.K_SPACE and operations:
                random.shuffle(ARRAY)
                sorting_started = False
                operations = 0
                screen.fill(GRAY)  # Clear screen for new drawing

    draw_complexity_message()  # Display the complexity message

    if sorting_started:
        operations = bubble_sort(ARRAY)
        sorting_started = False  # Ensure sorting happens only once
        total_operations_text = font.render(f"Total Operations: {operations}", True, BLACK)
        screen.blit(total_operations_text, (WIDTH // 2 - total_operations_text.get_width() // 2, HEIGHT - 30))
        pygame.display.flip()

    if not operations:
        draw_array(ARRAY, 0)

pygame.quit()
