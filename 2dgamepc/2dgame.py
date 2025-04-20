import pygame
import sys

class Player:
    def __init__(self, x, y, size, color, speed):
        self.x = x
        self.y = y
        self.size = size
        self.color = color
        self.speed = speed

class PGame:
    def __init__(self, width=800, height=600):
        pygame.init()
        self.width = width
        self.height = height
        self.screen = pygame.display.set_mode((self.width, self.height))
        pygame.display.set_caption("PGame: Oklarla Yönetilen Oyun")
        self.clock = pygame.time.Clock()
        self.running = True

        # Oyuncu oluştur
        self.player = Player(
            x=self.width // 2,
            y=self.height // 2,
            size=50,
            color=(255, 0, 0),
            speed=5
        )
        self.enemy = Player(
            x=self.width-150,
            y=self.height-200,
            size=29,
            color=(255, 89, 0),
            speed=0
        )
    def handle_events(self):
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                self.running = False

    def update(self):
        keys = pygame.key.get_pressed()
        if keys[pygame.K_LEFT]:
            self.player.x -= self.player.speed
        if keys[pygame.K_RIGHT]:
            self.player.x += self.player.speed
        if keys[pygame.K_UP]:
            self.player.y -= self.player.speed
        if keys[pygame.K_DOWN]:
            self.player.y += self.player.speed

        # Sınır kontrolü
        self.player.x = max(0, min(self.width - self.player.size, self.player.x))
        self.player.y = max(0, min(self.height - self.player.size, self.player.y))

    def draw(self):
        self.screen.fill((0, 0, 0))  # Ekranı siyah temizle
        pygame.draw.rect(self.screen, self.player.color, (self.player.x, self.player.y, self.player.size, self.player.size))
        pygame.draw.rect(self.screen, self.enemy.color, (self.enemy.x, self.enemy.y, self.enemy.size, self.enemy.size))
        pygame.display.flip()

    def win(self):
        if self.player.x == self.enemy.x:
           print("win")
           self.running = False

    def run(self):
        while self.running:
            self.win()
            self.handle_events()
            self.update()
            self.draw()
            self.clock.tick(60)
          

        pygame.quit()

if __name__ == "__main__":
    game = PGame()
    game.run()
