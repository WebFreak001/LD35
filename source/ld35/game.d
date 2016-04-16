module ld35.game;

import d2d;

class Game1 : Game
{
	override void start()
	{
		windowWidth = 800;
		windowHeight = 480;
		windowTitle = "LD35";
		maxFPS = 60;
		flags |= WindowFlags.Resizable;
	}

	override void load()
	{
		font = new TTFFont();
		font.load("res/robotomono/RobotoMono-Medium.ttf", 32);

		text = new TTFText(font);
		text.text = "Press shift to create a shape";

		successText = new TTFText(font);
		successText.text = "CONGRATULATIONS ON BEATING THE GAME!";
		
		shapeTex = new Texture("res/pixel.png");
		shape = RectangleShape.create(shapeTex, vec2(0, 0), vec2(100, 100));
		shape.origin = vec2(50, 100);
	}

	override void update(float delta)
	{
		if (success)
		{
			successTime += delta * 2;
			if (successTime > 1)
				successTime = 1;
		}
	}

	override void onEvent(Event event)
	{
		switch (event.type)
		{
		case Event.Type.Resized:
			window.resize(event.width, event.height);
			break;
		case Event.Type.KeyReleased:
			if (event.key == SDLK_LSHIFT || event.key == SDLK_RSHIFT)
			{
				success = true;
			}
			break;
		default:
			break;
		}
	}

	override void draw()
	{
		window.clear(Color3.DarkSlateBlue);
		if (success)
		{
			successText.scaling = vec2(successTime, successTime);
			successText.origin = vec2(cast(int)(successText.size.x * 0.5f), 0);
			successText.position = vec2(cast(int)(window.width * 0.5f),
				cast(int)(window.height * 0.5f) + 64);
			shape.position = successText.position();
			shape.draw(window);
			successText.draw(window);
		}
		else
		{
			text.position = vec2(cast(int)((window.width - text.size.x) * 0.5f),
				window.height - text.size.y - 16);
			text.draw(window);
		}
	}

private:
	TTFFont font;
	TTFText text;
	TTFText successText;
	RectangleShape shape;
	Texture shapeTex;
	float successTime = 0;
	bool success = false;
}
