# New Hand in Mootown

[Itch.io page](https://dairycultist.itch.io/new-hand-in-mootown)

In order to combat depression, I'm making a game that's fun (and imperfect).
The game should come out at some point, OK? So manage the scope, OK?

the gameloop is gonna be more focused ("farming" was a bit too broad)

## Befriending moo moos

dialogue system

find out a moo moo's favourite food through dialogue, feed them enough til
they're visibly chonky, they give you new, more intimate dialogue, and then ur
done with them + you get a gift (bottles of their own milk, keys to new areas,
etc). moo moos will only eat their favourite food, and only until they're
full (where you no longer have to feed them for the rest of the playthrough).
the goal of the game is to fully feed every single moo moo.

You can earn a gate key for a region by befriending local moo moos, allowing
you to access more land. befriending the shopkeep unlocks the next region (with
different terrain, shops, and moo moos), whereas befriending townsfolk
may unlock you secret, optional areas (with particularly difficult plots). or
they may just give you milk!

maybe some moo moos have more elaborate quests you can help them out with (like
finding their lost trowel) but that's an idea for later

## Other Notes

aesthetic character art https://www.youtube.com/watch?v=R5PVgKB3crY

whether I like it or not, I gotta have the moo moos (that aren't shopkeeps)
wander around and talk to other moo moos. not just because it makes the world
seem more real, but because character interactions make your story

todo:
1) finish starting area map (maybe some exploration area?) (slightly uneven terrain, a few tiny houses on stilts for you and the moo moos, closed gate)
2) draw Jess (and maybe another exploring moo moo)
3) dialogue system + requests
4) gate key (as part of a request reward!) + end of demo screen

https://docs.godotengine.org/en/stable/tutorials/3d/using_gridmaps.html

3 mesh system: 1 visible, 1 collision, 1 grass placement

paths are gonna have a spritesheet texture (straight, end, T, idk)

World is pre-hand-crafted with pre-determined regions for garden plots and stuff.

moo moos are just 2D textures like paper mario, instead of full, cumbersome, 3D models.

Most interactions occur by picking up objects and bumping them into other
objects. For example, a bag of 10 carrots seeds being placed onto an empty
garden plot will plant a carrot in the plot, removing one seed from the bag.

crop ideas:
- onion (twinion, grows two in one plot? yellow and red?)
- potato
- cabbagecake (cabbage, but it's a cupcake)

[jolt](https://godotengine.org/storage/releases/4.4/video/godot_jolt.webm)

## Credits

![skybox made with AI that I should probably replace before DEMO release](https://sketchfab.com/3d-models/free-skybox-anime-sky-56a60c1d1e8b44eabff138374f996d8f)

![Font source](https://www.dafont.com/game-bubble.font?text=Carrot+%28%A210%29)
