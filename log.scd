// History, as it was on Sat Jul 27 16:16:05 2019.

[
[ 0, 'me', "(
SynthDef(\"grain-asr\", {arg buffer, rate = 0.2, startPos = 0, gate = 1, att = 0.01, rel = 1, amp = 1, pan = 0;
	var env, snd;
	env = Env.asr(att, amp, rel).kr(gate: gate, doneAction: 2);
	snd = PlayBuf.ar(1, 2, rate: rate, startPos: startPos * BufSamples.kr(buffer));
	snd = snd * env;
	Out.ar(0, Pan2.ar(snd, pan));
}).add;
)" ],
[ 1.1566446639999, 'me', "(
~yyy5 = Pbind(
	\\instrument, \"grain-asr\",
	\\buffer, b,
	\\startPos, 0.7, // 0.0=beginning of sample, 0.5=half way into sample, 1.0=end of sample
	\\dur, 12,
	\\att, 10.001,
	\\rel, 11,
	\\rate, Pwhite(-1.2, 10.5), // 1=original speed, 0.5=half speed, 2=twice speed, etc.
	// a negative number for \\rate makes sound goes backward
	\\amp, 0.75,
	\\pan, Pwhite(-1.0, 1.0),
	\\legato, 1
);
)" ],
[ 3.130261398, 'me', "~yyy5.play;" ],
[ 41.870496305, 'me', "~x" ],
[ 44.162494396, 'me', "~y" ],
[ 47.181416967, 'me', "g.proc_(BBCPPermute.new(
  10/~x,
  2+(~y/12),
  {arg index, n;  if(index%2==0,{index+1},{index-1})},{arg index; if((index==4) || (index==7), 0, 6)}));" ],
[ 74.406064655, 'me', "SynthDef(\"granular_sampling\",
        {arg trigger = 0, graindur = 0.2, sndbuf, transp = 1,
         pos = 0, pan = 0, envbuf = 1, amp = 1, gate = 1;
	var env, snd;
	RecordBuf.ar(SoundIn.ar(0), sndbuf, loop: 1);
	env = EnvGen.kr(Env.asr, gate, levelScale: amp, doneAction: 2);
	snd = GrainBuf.ar(
		numChannels: 1,
		trigger: Impulse.kr(trigger),
		dur: graindur,
		sndbuf: sndbuf,
		rate: transp,
		pos: pos,
		pan: pan,
		envbufnum: envbuf);
        snd = DelayC.ar(snd, 0.1, 0.1); // add delay OR add some reverg :)
//        snd = GVerb.ar(BPF.ar(snd, 90.midicps), roomsize:300, revtime:55, drylevel:0.5);
        snd = snd!2 * 0.8; // many ways to add the src :)
	Out.ar(0, snd * env ); // use the envelope, and out

	// this is a freak :) but get's env and stereo ; with out arts)
	// Out.ar(0, (snd!2 * 0.7) * env );
        // Plain and mono out
	// Out.ar(0, (snd * env) + SoundIn.ar(0,1));
}).add;" ],
[ 82.859390601, 'me', "Pdef(\\a, Pbind(
	\\instrument, \"granular_sampling\",
	\\trigger, 8,
	\\graindur, Pexprand(0.1, 10.9, inf),
	\\sndbuf, ~bufferBag.take,
  \\transp, Prand([1/4,1/3,1/2,2/3,3/4,1]/~y*~x, inf),
	\\pos, 0,
	\\pan, Prand([-1, 0.2, 1, 0.4], inf),
	\\amp, Prand([0.5, 0.9], inf),
	\\envbuf, 1,
	\\dur, Prand([1+1/3,1/2,2/3,3/4,1]*12, inf),
));" ],
[ 117.921460309, 'me', "c.tempoclock.schedAbs(c.tempoclock.nextBar, {
	Ndef(\\layers).add(Ndef(\\m2));
	nil;
});" ],
[ 138.956737339, 'me', "c.tempoclock.schedAbs(c.tempoclock.nextBar, {
	Ndef(\\layers).add(Ndef(\\fx2));
	nil;
});" ],
[ 150.716076222, 'me', "c.tempoclock.schedAbs(c.tempoclock.nextBar, {
	Ndef(\\layers).add(Ndef(\\hh2));
	nil;
});" ],
[ 161.670395969, 'me', "c.tempoclock.schedAbs(c.tempoclock.nextBar, {
	Ndef(\\layers).add(Ndef(\\l3b));
	nil;
});" ],
[ 169.540991575, 'me', "Pdef(\\a2, Pbind(
	\\instrument, \"granular_sampling\",
	\\trigger, 8,
	\\graindur, Pexprand(0.1, ~y.abs, inf),
	\\sndbuf, ~takenBuf,
  \\transp, Prand([1/4,1/3,1/2,2/3,3/4,1]*~y*~x*10, inf),
	\\pos, 0,
	\\pan, Prand([1, -0.2, -1, -0.4], inf),
	\\amp, Prand([0.8, 0.9], inf),
	\\envbuf, 0,
	\\dur, Prand([1+1/3,1/2,2/3,3/4,1]*12, inf),
));" ],
[ 199.328861178, 'me', "Ndef(\\layers).sources;" ],
[ 212.389761884, 'me', "Ndef(\\layers).add(Ndef(\\l0));" ],
[ 219.363949646, 'me', "c.tempoclock.schedAbs(c.tempoclock.nextBar, {
	Ndef(\\layers).add(Ndef(\\l1));
	nil;
});" ],
[ 223.598420931, 'me', "g.proc_(WarpCutProc1.new)" ],
[ 226.595249076, 'me', "i.play(c);" ],
[ 227.787224349, 'me', "k.play(c);" ],
[ 234.895159485, 'me', "k.proc_(BBCutProc11.new)" ],
[ 249.659748858, 'me', "Ndef(\\layers).sources;" ],
[ 252.621783069, 'me', "Ndef(\\layers).removeAt(4);" ],
[ 260.982885773, 'me', "Ndef(\\layers).removeAt(4);" ],
[ 262.912676788, 'me', "Ndef(\\layers).removeAt(5);" ],
[ 266.344306352, 'me', "Ndef(\\layers).sources;" ],
[ 270.611436369, 'me', "Ndef(\\layers).removeAt(2);" ],
[ 277.327129937, 'me', "Pdef(\\a).stop;" ],
[ 282.115020178, 'me', "(
~yyy2 = Pbind(
	\\instrument, \"grain-asr\",
	\\buffer, b,
	\\startPos, Prand([0.44, 0.32, 0.6215, 0.8], inf),
	\\dur, Pwhite(9, 15),
	\\att, 0.201,
	\\rel, 0.1,
	\\rate, Pn(Pgeom(-0.1, 1.1, 20)),
	\\amp, Pwhite(1.2, 1.75),
	\\pan, Pwhite(-1.0, 1.0),
	\\legato, 1
);
)" ],
[ 283.972052341, 'me', "~yyy2.play;" ],
[ 295.027376111, 'me', "~x.abs" ],
[ 296.936979934, 'me', "(
~yyy2 = Pbind(
	\\instrument, \"grain-asr\",
	\\buffer, b,
	\\startPos, Prand([0.44, 0.32, 0.6215, 0.8] * ~x.abs, inf),
	\\dur, Pwhite(9, 15),
	\\att, 0.201,
	\\rel, 0.1,
	\\rate, Pn(Pgeom(-0.1, 1.1, 20)),
	\\amp, Pwhite(1.2, 1.75),
	\\pan, Pwhite(-1.0, 1.0),
	\\legato, 1
);
)" ],
[ 313.074377424, 'me', "d.play(c);" ],
[ 315.289542388, 'me', "d.proc_(SQPusher1.new)" ],
[ 317.679284959, 'me', "i.stop;" ],
[ 320.774852148, 'me', "k.proc_(WarpCutProc1.new(probs:[0.1, 0.5, 0.09, 0.07]*~x, phraselength:6, accel:0.25, bpsd:5))" ],
[ 323.594221178, 'me', "g.proc_(WarpCutProc1.new)" ],
[ 326.630016743, 'me', "f.play(c);" ],
[ 328.940114216, 'me', "f.proc_(BBCutProc11.new)" ],
[ 336.467917218, 'me', "Ndef(\\layers).removeAt(8);" ],
[ 338.114845114, 'me', "Ndef(\\layers).removeAt(7);" ],
[ 342.217682444, 'me', "Ndef(\\layers).removeAt(5);" ],
[ 343.824745049, 'me', "Ndef(\\layers).sources;" ],
[ 347.124679674, 'me', "Ndef(\\layers).removeAt(2);" ],
[ 348.280692449, 'me', "Ndef(\\layers).sources;" ],
[ 351.078157837, 'me', "Ndef(\\layers).removeAt(10);" ],
[ 352.548560107, 'me', "Ndef(\\layers).sources;" ],
[ 369.95216861, 'me', "~yyy2.stop;" ],
[ 373.566501549, 'me', "~yyy2.release(10);" ],
[ 377.572189493, 'me', "~yyy2.clear;" ],
[ 381.987880269, 'me', "~yyy5.stop;" ],
[ 383.030807968, 'me', "~yyy4.stop;" ],
[ 385.966173741, 'me', "~yyy2.stop;" ],
[ 387.480726918, 'me', "~yyy2.release(10);" ],
[ 388.247715119, 'me', "~yyy5.release(10);" ],
[ 388.785658507, 'me', "~yyy4.release(10);" ],
[ 391.773967282, 'me', "~yyy2.clear;" ],
[ 392.465564958, 'me', "~yyy5.clear;" ],
[ 396.037009844, 'me', "(
~yyy3 = Pbind(
	\\instrument, \"grain-asr\",
	\\buffer, b,
	\\startPos, Pwhite(0.0, 0.1),
	\\dur, 5,
	\\att, 0.1,
	\\rel, 0.4,
	\\rate, Pseq([1, -5, 3, 3.3, -0.5, 1.2, 11/10], inf),
	\\amp, Pwhite(1.02, 1.95),
	\\pan, Pwhite(-1.0, 1.0),
	\\legato, Pn(Pgeom(0.1, 1.05, 40))
);
)" ],
[ 398.972567938, 'me', "~yyy3.play;" ],
[ 409.317199021, 'me', "i.stop;" ],
[ 410.92807871, 'me', "k.stop;" ],
[ 413.450613369, 'me', "g.stop;" ],
[ 417.452208209, 'me', "f.proc_(SQPusher1.new)" ],
[ 428.066693797, 'me', "Ndef(\\layers).add(Ndef(\\lc2));" ],
[ 433.284218334, 'me', "c.tempoclock.schedAbs(c.tempoclock.nextBar, {
	Ndef(\\layers).add(Ndef(\\lc1));
	nil;
});" ],
[ 454.957900519, 'me', "c.tempoclock.schedAbs(c.tempoclock.nextBar, {
	Ndef(\\layers).add(Ndef(\\l0));
	nil;
});" ],
[ 462.401672849, 'me', "c.tempoclock.schedAbs(c.tempoclock.nextBar, {
	Ndef(\\layers).add(Ndef(\\l1));
	nil;
});" ],
[ 493.214578891, 'me', "Ndef('reverb').set('lowx', 0.84375, 'amp', 0.66015625, 'damp', 0.875, 'size', 0.5, 'highband', 5829.4153471361, 't60', 0.16483258382257, 'mdepth', 17.96875, 'mfreq', 0.0, 'highx', 0.0, 'lowband', 100.0, 'fadeTime', 1, 'earlydiff', 0.703125, 'midx', 0.5546875);" ],
[ 501.642810664, 'me', "(
~yyy = Pbind(
	\\instrument, \"grain-asr\",
	\\buffer, b,
	\\startPos, Pseq([0.4, 0.32, 0.6215, 0.8], inf) + Pwhite(0.0, 0.1),
	\\dur, 0.3,
	\\att, 4.001,
	\\rel, 11,
	\\rate, Prand([Pn(2, 4), 1, 4], inf),
	\\amp, 1.75,
	\\pan, Pwhite(-1.0, 1.0),
	\\legato, 0
);
)" ],
[ 504.021453635, 'me', "~yyy.stop;" ],
[ 505.72678052, 'me', "~yyy.play;" ],
[ 515.972631263, 'me', "(
~yyy5 = Pbind(
	\\instrument, \"grain-asr\",
	\\buffer, b,
	\\startPos, 0.7, // 0.0=beginning of sample, 0.5=half way into sample, 1.0=end of sample
	\\dur, 12,
	\\att, 10.001,
	\\rel, 11,
	\\rate, Pwhite(-1.2, 10.5), // 1=original speed, 0.5=half speed, 2=twice speed, etc.
	// a negative number for \\rate makes sound goes backward
	\\amp, 0.75,
	\\pan, Pwhite(-1.0, 1.0),
	\\legato, 11
);
)" ],
[ 517.861294052, 'me', "~yyy5.play;" ],
[ 525.177118607, 'me', "~yyy.stop;" ],
[ 526.565022431, 'me', "~yyy2.stop;" ],
[ 527.146956154, 'me', "~yyy3.stop;" ],
[ 528.014050251, 'me', "~yyy4.stop;" ],
[ 531.053921347, 'me', "~yyy.clear;" ],
[ 531.369988567, 'me', "~yyy2.clear;" ],
[ 531.674965591, 'me', "~yyy3.clear;" ],
[ 539.731093848, 'me', "(
~yyy4 = Pbind(
	\\instrument, \"grain-asr\",
	\\buffer, b,
	\\startPos, Pseq([1.04, 4.12, 0.215, 0.78] / ~y, inf),
	\\dur, 15/11,
	\\att, 0.1,
	\\rel, 3,
	\\rate, 31/25, // normal speed, but reverse
	\\amp, 1.75,
	\\pan, Pwhite(-1.0, 1.0),
	\\legato, 0.7
);
)" ],
[ 547.765464445, 'me', "~yyy4.playExt(c);" ],
[ 562.756957746, 'me', "(
~yyy = Pbind(
	\\instrument, \"grain-asr\",
	\\buffer, b,
	\\startPos, Pseq([0.4, 0.32, 0.6215, 0.8], inf) + Pwhite(0.0, 0.1),
	\\dur, 0.3,
	\\att, 4.001,
	\\rel, 11,
	\\rate, Prand([Pn(2, 4), 1, 4], inf),
	\\amp, 1.75,
	\\pan, Pwhite(-1.0, 1.0),
	\\legato, 0
);
)" ],
[ 564.877597179, 'me', "~yyy.playExt(c);" ],
[ 574.43220041, 'me', "d.stop;" ],
[ 576.646268478, 'me', "f.stop;" ],
[ 579.832108972, 'me', "k.stop;" ],
[ 582.6790648, 'me', "i.stop;" ],
[ 590.070031818, 'me', "~n4.clear;" ],
[ 593.01136086, 'me', "// Play it with Pbind ...
// with 'just 8' grains it bounces around nicely ;)
~n4 = Pbind(
	\\instrument, \"granular_sampling\",
	\\trigger,~x/~r1 * 18,
	\\graindur, Ndef(\\pm_l2b),
	\\sndbuf, b,
	\\transp, Prand([1/4,1/3,1/2,2/3,3/4,1]/~x/~y, inf),
	//\\pos, 0,
	\\pos, Pseq([1/4,1/2,3/4], inf),
	\\pan, Prand([-1, 1, 0.2, -0.2, 0.5, -0.5], inf),
	\\amp, Prand([1.5, 1.9], inf),
	\\envbuf, 1,
	\\dur, Prand([1+1/3,1/2,2/3,3/4,1]/~y, inf),
);

~n4.play;" ],
[ 601.711176319, 'me', "(
~yyy2 = Pbind(
	\\instrument, \"grain-asr\",
	\\buffer, b,
	\\startPos, Prand([0.44, 0.32, 0.6215, 0.8] * ~x.abs, inf),
	\\dur, Pwhite(9, 15),
	\\att, 0.201,
	\\rel, 0.1,
	\\rate, Pn(Pgeom(-0.1, 1.1, 20)),
	\\amp, Pwhite(1.2, 1.75),
	\\pan, Pwhite(-1.0, 1.0),
	\\legato, 1
);
)" ],
[ 604.583670296, 'me', "~yyy2.stop;" ],
[ 606.673853304, 'me', "~yyy2.playExt(c);" ],
[ 613.365182053, 'me', "a.set(\\tempo, [0.25, 45/60, 10/7, 6/10, 7/10, 0.7, 1.1, 1.7, 2.2, 2.7, 2.4, 4.7].choose);" ],
[ 623.484632455, 'me', "Ndef(\\layers).add(Ndef(\\hh1));" ],
[ 633.042238628, 'me', "f.play(c);" ],
[ 635.091281361, 'me', "f.proc_(WarpCutProc1.new)" ],
[ 638.249136514, 'me', "d.play(c);" ],
[ 640.993217398, 'me', "d.proc_(WarpCutProc1.new)" ],
[ 657.192610247, 'me', "Ndef('reverb').set('wet', 0.9921875, 'lowx', 0.84375, 'amp', 0.66015625, 'damp', 0.31443298969072, 'size', 2.7938144329897, 'highband', 1024.0219794048, 't60', 60, 'mdepth', 4.639175257732, 'highx', 0.0, 'mfreq', 0.10309278350515, 'lowband', 2450.0822520097, 'fadeTime', 1, 'earlydiff', 0.421875, 'midx', 0.70618556701031);" ],
[ 658.860183881, 'me', "Ndef('reverb').set('lowx', 0.84375, 'amp', 0.66015625, 'damp', 0.671875, 'size', 0.94921875, 'highband', 4450.794062356, 't60', 60, 'mdepth', 17.96875, 'mfreq', 0.0, 'highx', 0.0, 'lowband', 2450.0822520097, 'earlydiff', 0.421875, 'midx', 0.5546875);" ],
[ 660.298565511, 'me', "Ndef('reverb').set('wet', 0.9921875, 'lowx', 0.84375, 'amp', 0.66015625, 'damp', 0.31443298969072, 'size', 2.7938144329897, 'highband', 1024.0219794048, 't60', 60, 'mdepth', 4.639175257732, 'highx', 0.0, 'mfreq', 0.10309278350515, 'lowband', 2450.0822520097, 'fadeTime', 1, 'earlydiff', 0.421875, 'midx', 0.70618556701031);" ],
[ 662.175344137, 'me', "Ndef('reverb').set('lowx', 0.609375, 'amp', 0.38092041015625, 'damp', 0.2890625, 'size', 0.6171875, 'highband', 7233.9416273667, 't60', 4.0375572334984, 'mdepth', 0.0, 'mfreq', 2.03125, 'highx', 0.2265625, 'lowband', 681.56675509913, 'fadeTime', 1, 'earlydiff', 0.765625, 'midx', 0.515625);" ],
[ 663.470510085, 'me', "Ndef('reverb').set('wet', 0.9921875, 'lowx', 0.84375, 'amp', 0.66015625, 'damp', 0.31443298969072, 'size', 2.7938144329897, 'highband', 1024.0219794048, 't60', 60, 'mdepth', 4.639175257732, 'highx', 0.0, 'mfreq', 0.10309278350515, 'lowband', 2450.0822520097, 'fadeTime', 1, 'earlydiff', 0.421875, 'midx', 0.70618556701031);" ],
[ 665.027263528, 'me', "Ndef('reverb').set('lowx', 0.609375, 'amp', 0.38092041015625, 'damp', 0.2890625, 'size', 0.6171875, 'highband', 7233.9416273667, 't60', 4.0375572334984, 'mdepth', 0.0, 'mfreq', 2.03125, 'highx', 0.2265625, 'lowband', 681.56675509913, 'fadeTime', 1, 'earlydiff', 0.765625, 'midx', 0.515625);" ],
[ 666.398665263, 'me', "Ndef('reverb').set('wet', 0.9921875, 'lowx', 0.84375, 'amp', 0.66015625, 'damp', 0.31443298969072, 'size', 2.7938144329897, 'highband', 1024.0219794048, 't60', 60, 'mdepth', 4.639175257732, 'highx', 0.0, 'mfreq', 0.10309278350515, 'lowband', 2450.0822520097, 'fadeTime', 1, 'earlydiff', 0.421875, 'midx', 0.70618556701031);" ],
[ 668.250781262, 'me', "Ndef('reverb').set('lowx', 0.609375, 'amp', 0.38092041015625, 'damp', 0.2890625, 'size', 0.6171875, 'highband', 7233.9416273667, 't60', 4.0375572334984, 'mdepth', 0.0, 'mfreq', 2.03125, 'highx', 0.2265625, 'lowband', 681.56675509913, 'fadeTime', 1, 'earlydiff', 0.765625, 'midx', 0.515625);" ],
[ 669.652260769, 'me', "Ndef('reverb').set('wet', 0.9921875, 'lowx', 0.84375, 'amp', 0.66015625, 'damp', 0.31443298969072, 'size', 2.7938144329897, 'highband', 1024.0219794048, 't60', 60, 'mdepth', 4.639175257732, 'highx', 0.0, 'mfreq', 0.10309278350515, 'lowband', 2450.0822520097, 'fadeTime', 1, 'earlydiff', 0.421875, 'midx', 0.70618556701031);" ],
[ 671.138108362, 'me', "Ndef('reverb').set('lowx', 0.84375, 'amp', 0.66015625, 'damp', 0.671875, 'size', 0.94921875, 'highband', 4450.794062356, 't60', 60, 'mdepth', 17.96875, 'mfreq', 0.0, 'highx', 0.0, 'lowband', 2450.0822520097, 'earlydiff', 0.421875, 'midx', 0.5546875);" ],
[ 686.895867793, 'me', "Ndef('reverb').set('lowx', 0.609375, 'amp', 0.38092041015625, 'damp', 0.2890625, 'size', 0.6171875, 'highband', 7233.9416273667, 't60', 4.0375572334984, 'mdepth', 0.0, 'mfreq', 2.03125, 'highx', 0.2265625, 'lowband', 681.56675509913, 'fadeTime', 1, 'earlydiff', 0.765625, 'midx', 0.515625);" ],
[ 697.555084358, 'me', "f.proc_(BBCutProc11.new)" ],
[ 699.62321881, 'me', "d.proc_(BBCutProc11.new)" ],
[ 702.139933405, 'me', "i.stop;" ],
[ 705.290287036, 'me', "i.play(c);" ],
[ 709.504729011, 'me', "k.stop;" ],
[ 712.940738961, 'me', "k.play(c);" ],
[ 717.609712408, 'me', "k.stop;" ],
[ 722.935933408, 'me', "i.proc_(WarpCutProc1.new(probs:[0.1, 0.5, 0.9, 0.7]*~x, phraselength:14, accel:2, bpsd:0.5))" ],
[ 729.411423098, 'me', "g.stop;" ],
[ 734.41943259, 'me', "g.play(c);" ],
[ 735.296063978, 'me', "g.proc_(SQPusher1.new)" ],
[ 747.898965679, 'me', "g.stop;" ],
[ 756.027072092, 'me', "Ndef(\\layers).release(50);" ],
[ 779.082123615, 'me', "~yyy5.release(10);" ],
[ 779.532466004, 'me', "~yyy4.release(10);" ],
[ 780.978497249, 'me', "~yyy2.release(10);" ],
[ 781.768465581, 'me', "~yyy.release(10);" ],
[ 782.350655321, 'me', "~yyy3.release(10);" ],
[ 792.310822821, 'me', "~yyy5.clear;" ],
[ 793.121153947, 'me', "~yyy4.clear;" ],
[ 793.731035352, 'me', "~yyy3.clear;" ],
[ 794.347127252, 'me', "~yyy2.clear;" ],
[ 794.846126749, 'me', "~yyy.clear;" ],
[ 799.941853713, 'me', "Ndef('reverb').set('lowx', 0.609375, 'amp', 0.38092041015625, 'damp', 0.2890625, 'size', 0.6171875, 'highband', 7233.9416273667, 't60', 4.0375572334984, 'mdepth', 0.0, 'mfreq', 2.03125, 'highx', 0.2265625, 'lowband', 681.56675509913, 'fadeTime', 1, 'earlydiff', 0.765625, 'midx', 0.515625);" ],
[ 801.307494114, 'me', "Ndef('reverb').set('lowx', 0.84375, 'amp', 0.66015625, 'damp', 0.671875, 'size', 0.94921875, 'highband', 4450.794062356, 't60', 60, 'mdepth', 17.96875, 'mfreq', 0.0, 'highx', 0.0, 'lowband', 2450.0822520097, 'earlydiff', 0.421875, 'midx', 0.5546875);" ],
[ 807.223748893, 'me', "Ndef('reverb').set('wet', 0.9921875, 'lowx', 0.84375, 'amp', 0.66015625, 'damp', 0.31443298969072, 'size', 2.7938144329897, 'highband', 1024.0219794048, 't60', 60, 'mdepth', 4.639175257732, 'highx', 0.0, 'mfreq', 0.10309278350515, 'lowband', 2450.0822520097, 'fadeTime', 1, 'earlydiff', 0.421875, 'midx', 0.70618556701031);" ],
[ 807.962076328, 'me', "Ndef('reverb').set('lowx', 0.84375, 'amp', 0.66015625, 'damp', 0.671875, 'size', 0.94921875, 'highband', 4450.794062356, 't60', 60, 'mdepth', 17.96875, 'mfreq', 0.0, 'highx', 0.0, 'lowband', 2450.0822520097, 'earlydiff', 0.421875, 'midx', 0.5546875);" ],
[ 809.803244464, 'me', "Ndef('reverb').set('lowx', 0.609375, 'amp', 0.38092041015625, 'damp', 0.2890625, 'size', 0.6171875, 'highband', 7233.9416273667, 't60', 4.0375572334984, 'mdepth', 0.0, 'mfreq', 2.03125, 'highx', 0.2265625, 'lowband', 681.56675509913, 'fadeTime', 1, 'earlydiff', 0.765625, 'midx', 0.515625);" ],
[ 816.358726771, 'me', "i.stop;" ],
[ 817.895755797, 'me', "k.stop;" ],
[ 818.987640088, 'me', "g.stop;" ],
[ 830.818005965, 'me', "Ndef(\\layers).sources;" ],
[ 841.386332215, 'me', "Ndef(\\layers).removeAll;" ],
[ 846.774290432, 'me', "Ndef(\\layers).sources;" ],
[ 852.525598967, 'me', "c.tempoclock.schedAbs(c.tempoclock.nextBar, {
	Ndef(\\layers).add(Ndef(\\l1));
	nil;
});" ],
[ 866.473086754, 'me', "Ndef(\\layers).add(Ndef(\\mm2));" ],
[ 880.442413944, 'me', "f.stop;" ],
[ 884.126353196, 'me', "f.play(c);" ],
[ 885.898423999, 'me', "d.stop;" ],
[ 888.084576183, 'me', "i.stop;" ],
[ 889.978240585, 'me', "k.stop;" ],
[ 891.989415972, 'me', "f.proc_(WarpCutProc1.new)" ],
[ 894.486752336, 'me', "a.set(\\tempo, [0.25, 45/60, 10/7, 6/10, 7/10, 0.7, 1.1, 1.7, 2.2, 2.7, 2.4, 4.7].choose);" ],
[ 901.613057532, 'me', "Ndef(\\ll2).fadeTime = 4;
Ndef(\\ll2, {
    var src1 = Ndef(\\mic1).ar * \\amp.kr(1);
    var src2 = Ndef(\\mic2).ar * \\amp.kr(1);
	Balance2.ar(
    RHPF.ar(DelayC.ar(PitchShift.ar(src1, 0.3, 0.5, ~cdd/100),11/~x,8),1200),
    RLPF.ar(DelayC.ar(PitchShift.ar(src2, 1.3, 0.35),~ccd*10,8),1500)
  )
});" ],
[ 913.047328251, 'me', "Ndef(\\layers).add(Ndef(\\lc1));" ],
[ 920.61427664, 'me', "c.tempoclock.schedAbs(c.tempoclock.nextBar, {
	Ndef(\\layers).add(Ndef(\\ll2));
	nil;
});" ],
[ 934.042259104, 'me', "Ndef('reverb').set('wet', 0.9921875, 'lowx', 0.84375, 'amp', 0.66015625, 'damp', 0.31443298969072, 'size', 2.7938144329897, 'highband', 1024.0219794048, 't60', 60, 'mdepth', 4.639175257732, 'highx', 0.0, 'mfreq', 0.10309278350515, 'lowband', 2450.0822520097, 'fadeTime', 1, 'earlydiff', 0.421875, 'midx', 0.70618556701031);" ],
[ 942.159335182, 'me', "Pdef(\\a2).stop;" ],
[ 943.687437764, 'me', "Pdef(\\a).stop;" ],
[ 944.434276421, 'me', "Pdef(\\a).clear;" ],
[ 945.605328714, 'me', "Pdef(\\a2).clear;" ],
[ 967.236388254, 'me', "Pdef(\\a, Pbind(
	\\instrument, \"granular_sampling\",
	\\trigger, 8,
	\\graindur, Pexprand(0.1, 10.9, inf),
	\\sndbuf, ~bufferBag.take,
  \\transp, Prand([1/4,1/3,1/2,2/3,3/4,1]/~y*~x, inf),
	\\pos, 0,
	\\pan, Prand([-1, 0.2, 1, 0.4], inf),
	\\amp, Prand([0.5, 0.9], inf),
	\\envbuf, 2,
	\\dur, Prand([1+1/3,1/2,2/3,3/4,1]*12, inf),
));" ],
[ 1004.075592818, 'me', "c.tempoclock.schedAbs(c.tempoclock.nextBar, {
	Ndef(\\layers).add(Ndef(\\lc2));
	nil;
});" ],
[ 1009.992514365, 'me', "d.stop;" ],
[ 1012.136997473, 'me', "f.stop;" ],
[ 1014.486931407, 'me', "i.stop;" ],
[ 1016.437895082, 'me', "k.stop;" ],
[ 1018.342775781, 'me', "g.stop;" ],
[ 1022.304269581, 'me', "Ndef('reverb').set('lowx', 0.84375, 'amp', 0.66015625, 'damp', 0.671875, 'size', 0.94921875, 'highband', 4450.794062356, 't60', 60, 'mdepth', 17.96875, 'mfreq', 0.0, 'highx', 0.0, 'lowband', 2450.0822520097, 'earlydiff', 0.421875, 'midx', 0.5546875);" ],
[ 1025.153085155, 'me', "Ndef('reverb').set('lowx', 0.609375, 'amp', 0.38092041015625, 'damp', 0.2890625, 'size', 0.6171875, 'highband', 7233.9416273667, 't60', 4.0375572334984, 'mdepth', 0.0, 'mfreq', 2.03125, 'highx', 0.2265625, 'lowband', 681.56675509913, 'fadeTime', 1, 'earlydiff', 0.765625, 'midx', 0.515625);" ],
[ 1025.84283979, 'me', "Ndef('reverb').set('lowx', 0.84375, 'amp', 0.66015625, 'damp', 0.671875, 'size', 0.94921875, 'highband', 4450.794062356, 't60', 60, 'mdepth', 17.96875, 'mfreq', 0.0, 'highx', 0.0, 'lowband', 2450.0822520097, 'earlydiff', 0.421875, 'midx', 0.5546875);" ],
[ 1027.565050317, 'me', "Ndef('reverb').set('wet', 0.9921875, 'lowx', 0.84375, 'amp', 0.66015625, 'damp', 0.31443298969072, 'size', 2.7938144329897, 'highband', 1024.0219794048, 't60', 60, 'mdepth', 4.639175257732, 'highx', 0.0, 'mfreq', 0.10309278350515, 'lowband', 2450.0822520097, 'fadeTime', 1, 'earlydiff', 0.421875, 'midx', 0.70618556701031);" ],
[ 1028.446766243, 'me', "Ndef('reverb').set('lowx', 0.84375, 'amp', 0.66015625, 'damp', 0.671875, 'size', 0.94921875, 'highband', 4450.794062356, 't60', 60, 'mdepth', 17.96875, 'mfreq', 0.0, 'highx', 0.0, 'lowband', 2450.0822520097, 'earlydiff', 0.421875, 'midx', 0.5546875);" ],
[ 1036.122569234, 'me', "Ndef(\\layers).sources;" ],
[ 1041.660296503, 'me', "Ndef(\\layers).add(Ndef(\\m2));" ],
[ 1063.144966918, 'me', "c.tempoclock.schedAbs(c.tempoclock.nextBar, {
	Ndef(\\layers).add(Ndef(\\l0));
	nil;
});" ],
[ 1067.50806076, 'me', "Ndef(\\layers).release(50);" ],
[ 1070.467772925, 'me', "g.stop;" ],
[ 1082.945507384, 'me', "Ndef('reverb').set('lowx', 0.84375, 'amp', 0.66015625, 'damp', 0.875, 'size', 0.5, 'highband', 5829.4153471361, 't60', 0.16483258382257, 'mdepth', 17.96875, 'mfreq', 0.0, 'highx', 0.0, 'lowband', 100.0, 'fadeTime', 1, 'earlydiff', 0.703125, 'midx', 0.5546875);" ],
[ 1085.359867862, 'me', "Ndef('reverb').set('lowx', 0.609375, 'amp', 0.38092041015625, 'damp', 0.2890625, 'size', 0.6171875, 'highband', 7233.9416273667, 't60', 4.0375572334984, 'mdepth', 0.0, 'mfreq', 2.03125, 'highx', 0.2265625, 'lowband', 681.56675509913, 'fadeTime', 1, 'earlydiff', 0.765625, 'midx', 0.515625);" ],
[ 1088.439630718, 'me', "Ndef('reverb').set('lowx', 0.84375, 'amp', 0.66015625, 'damp', 0.875, 'size', 0.5, 'highband', 5829.4153471361, 't60', 0.16483258382257, 'mdepth', 17.96875, 'mfreq', 0.0, 'highx', 0.0, 'lowband', 100.0, 'fadeTime', 1, 'earlydiff', 0.703125, 'midx', 0.5546875);" ],
[ 1089.128065676, 'me', "// REVERB PRESETS: //" ],
[ 1089.729870521, 'me', "Ndef('reverb').set('wet', 0.9921875, 'lowx', 0.84375, 'amp', 0.66015625, 'damp', 0.31443298969072, 'size', 2.7938144329897, 'highband', 1024.0219794048, 't60', 60, 'mdepth', 4.639175257732, 'highx', 0.0, 'mfreq', 0.10309278350515, 'lowband', 2450.0822520097, 'fadeTime', 1, 'earlydiff', 0.421875, 'midx', 0.70618556701031);" ],
[ 1095.831398016, 'me', "g.play(c);" ],
[ 1097.11539091, 'me', "k.play(c);" ],
[ 1099.814345435, 'me', "a.set(\\tempo,2.7);" ],
[ 1101.10682755, 'me', "a.set(\\tempo, [0.25, 45/60, 10/7, 6/10, 7/10, 0.7, 1.1, 1.7, 2.2, 2.7, 2.4, 4.7].choose);" ],
[ 1103.859156183, 'me', "f.stop;" ],
[ 1104.234144385, 'me', "f.play(c);" ],
[ 1105.39338725, 'me', "f.proc_(WarpCutProc1.new)" ],
[ 1109.427064704, 'me', "k.stop;" ],
[ 1110.780765296, 'me', "i.stop;" ],
[ 1111.16302263, 'me', "i.play(c);" ],
[ 1111.830596587, 'me', "i.proc_(WarpCutProc1.new(probs:[0.1, 0.5, 0.9, 0.7]*~x, phraselength:14, accel:2, bpsd:0.5))" ],
[ 1120.74457689, 'me', "Ndef('reverb').set('lowx', 0.609375, 'amp', 0.38092041015625, 'damp', 0.2890625, 'size', 0.6171875, 'highband', 7233.9416273667, 't60', 4.0375572334984, 'mdepth', 0.0, 'mfreq', 2.03125, 'highx', 0.2265625, 'lowband', 681.56675509913, 'fadeTime', 1, 'earlydiff', 0.765625, 'midx', 0.515625);" ],
[ 1121.767081772, 'me', "/* DREAMVERB */" ],
[ 1122.142253666, 'me', "Ndef('reverb').set('wet', 0.9921875, 'lowx', 0.84375, 'amp', 0.66015625, 'damp', 0.31443298969072, 'size', 2.7938144329897, 'highband', 1024.0219794048, 't60', 60, 'mdepth', 4.639175257732, 'highx', 0.0, 'mfreq', 0.10309278350515, 'lowband', 2450.0822520097, 'fadeTime', 1, 'earlydiff', 0.421875, 'midx', 0.70618556701031);" ],
[ 1123.314154291, 'me', "Ndef('reverb').set('lowx', 0.84375, 'amp', 0.66015625, 'damp', 0.671875, 'size', 0.94921875, 'highband', 4450.794062356, 't60', 60, 'mdepth', 17.96875, 'mfreq', 0.0, 'highx', 0.0, 'lowband', 2450.0822520097, 'earlydiff', 0.421875, 'midx', 0.5546875);" ],
[ 1123.894095939, 'me', "Ndef('reverb').set('wet', 0.9921875, 'lowx', 0.84375, 'amp', 0.66015625, 'damp', 0.31443298969072, 'size', 2.7938144329897, 'highband', 1024.0219794048, 't60', 60, 'mdepth', 4.639175257732, 'highx', 0.0, 'mfreq', 0.10309278350515, 'lowband', 2450.0822520097, 'fadeTime', 1, 'earlydiff', 0.421875, 'midx', 0.70618556701031);" ],
[ 1129.874252512, 'me', "~yyy5.release(10);
~yyy4.release(10);
~yyy3.release(10);
~yyy2.release(10);
~yyy.release(10);" ],
[ 1133.520005395, 'me', "~yyy5.stop;
~yyy4.stop;
~yyy3.stop;
~yyy2.stop;
~yyy.stop;" ],
[ 1135.363990381, 'me', "~yyy5.clear;
~yyy4.clear;
~yyy3.clear;
~yyy2.clear;
~yyy.clear;" ],
[ 1137.85036279, 'me', "(
~yyy4 = Pbind(
	\\instrument, \"grain-asr\",
	\\buffer, b,
	\\startPos, Pseq([1.04, 4.12, 0.215, 0.78] / ~y, inf),
	\\dur, 15/11,
	\\att, 0.1,
	\\rel, 3,
	\\rate, 31/25, // normal speed, but reverse
	\\amp, 1.75,
	\\pan, Pwhite(-1.0, 1.0),
	\\legato, 0.7
);
)" ],
[ 1139.715584609, 'me', "~yyy4.playExt(c);" ],
[ 1149.670110459, 'me', "(
~yyy5 = Pbind(
	\\instrument, \"grain-asr\",
	\\buffer, b,
	\\startPos, 0.7, // 0.0=beginning of sample, 0.5=half way into sample, 1.0=end of sample
	\\dur, 12,
	\\att, 10.001,
	\\rel, 11,
	\\rate, Pwhite(-1.2, 10.5), // 1=original speed, 0.5=half speed, 2=twice speed, etc.
	// a negative number for \\rate makes sound goes backward
	\\amp, 0.75,
	\\pan, Pwhite(-1.0, 1.0),
	\\legato, 11
);
)" ],
[ 1151.708379933, 'me', "~yyy5.playExt(c);" ],
[ 1155.68582403, 'me', "(
~yyy3 = Pbind(
	\\instrument, \"grain-asr\",
	\\buffer, b,
	\\startPos, Pwhite(0.0, 0.1),
	\\dur, 5,
	\\att, 0.1,
	\\rel, 0.4,
	\\rate, Pseq([1, -5, 3, 3.3, -0.5, 1.2, 11/10], inf),
	\\amp, Pwhite(1.02, 1.95),
	\\pan, Pwhite(-1.0, 1.0),
	\\legato, Pn(Pgeom(0.1, 1.05, 40))
);
)" ],
[ 1158.371230102, 'me', "~yyy3.playExt(c);" ],
[ 1170.138117936, 'me', "f.proc_(WarpCutProc1.new)" ],
[ 1171.520154594, 'me', "d.proc_(WarpCutProc1.new)" ],
[ 1173.432606441, 'me', "i.proc_(WarpCutProc1.new(probs:[0.1, 0.5, 0.9, 0.7]*~x, phraselength:14, accel:2, bpsd:0.5))" ],
[ 1176.147897159, 'me', "k.play(c);" ],
[ 1177.854162129, 'me', "k.proc_(WarpCutProc1.new(probs:[0.1, 0.5, 0.09, 0.07]*~x, phraselength:6, accel:0.25, bpsd:5))" ],
[ 1179.152864163, 'me', "g.stop;" ],
[ 1179.6859329, 'me', "g.play(c);" ],
[ 1180.55283653, 'me', "g.proc_(WarpCutProc1.new)" ],
[ 1192.669676602, 'me', "Ndef(\\layers).removeAll;" ],
[ 1217.515116442, 'me', "        Ndef(\\layers, { Splay.ar(\\in.ar(0!~numChans))  });
        Ndef(\\layers).fadeTime = 2.6;" ],
[ 1222.437352729, 'me', "        Ndef(\\layers).playN([13,14,15,16]);" ],
[ 1234.756771493, 'me', "Pdef(\\aaa, Pbind(
	\\instrument, \"granular_sampling\",
	\\trigger, 0.1,
	\\graindur, Pexprand(0.01 * ~pk, 10.9, inf),
	\\sndbuf, b,
	//\\pos, 0,
	\\pos, Pseq([1/4,1/2,3/4], inf),
	\\pan, 0,
	\\rate, Pseq([0.0625, 0.15]/4!4, inf),
	\\amp, Prand([0.15, 0.2, 0, 0.1, 0.412, 0.176, 1.2, 0.9], inf),
	\\envbuf, 5
));

Pdef(\\aaa).quant=12;

Pdef(\\aaa).play;" ],
[ 1241.994099611, 'me', "~yyy5.release(10);
~yyy4.release(10);
~yyy3.release(10);
~yyy2.release(10);
~yyy.release(10);" ],
[ 1252.311091026, 'me', "~yyy5.stop;
~yyy4.stop;
~yyy3.stop;
~yyy2.stop;
~yyy.stop;

~yyy5.clear;
~yyy4.clear;
~yyy3.clear;
~yyy2.clear;
~yyy.clear;" ],
[ 1257.950377869, 'me', "Ndef(\\layers).sources;" ],
[ 1264.234728857, 'me', "c.tempoclock.schedAbs(c.tempoclock.nextBar, {
	Ndef(\\layers).add(Ndef(\\l0));
	nil;
});" ],
[ 1268.252335996, 'me', "c.tempoclock.schedAbs(c.tempoclock.nextBar, {
	Ndef(\\layers).add(Ndef(\\l1));
	nil;
});" ],
[ 1275.337885769, 'me', "c.tempoclock.schedAbs(c.tempoclock.nextBar, {
	Ndef(\\layers).add(Ndef(\\ll2));
	nil;
});" ],
[ 1279.048172515, 'me', "c.tempoclock.schedAbs(c.tempoclock.nextBar, {
	Ndef(\\layers).add(Ndef(\\l3b));
	nil;
});" ],
[ 1283.302025128, 'me', "Ndef(\\monitor).add(Ndef(\\layers));" ],
[ 1294.687744114, 'me', "c.tempoclock.schedAbs(c.tempoclock.nextBar, {
	Ndef(\\layers).add(Ndef(\\mm2));
	nil;
});" ],
[ 1299.935324097, 'me', "c.tempoclock.schedAbs(c.tempoclock.nextBar, {
	Ndef(\\layers).add(Ndef(\\m2));
	nil;
});" ],
[ 1303.649167374, 'me', "k.stop;" ],
[ 1305.177055501, 'me', "i.stop;" ],
[ 1307.916263563, 'me', "d.stop;" ],
[ 1309.379149814, 'me', "f.stop;" ],
[ 1316.825803339, 'me', "Ndef('reverb').set('wet', 0.9921875, 'lowx', 0.84375, 'amp', 0.66015625, 'damp', 0.31443298969072, 'size', 2.7938144329897, 'highband', 1024.0219794048, 't60', 60, 'mdepth', 4.639175257732, 'highx', 0.0, 'mfreq', 0.10309278350515, 'lowband', 2450.0822520097, 'fadeTime', 1, 'earlydiff', 0.421875, 'midx', 0.70618556701031);" ],
[ 1317.548467459, 'me', "Ndef('reverb').set('lowx', 0.84375, 'amp', 0.66015625, 'damp', 0.671875, 'size', 0.94921875, 'highband', 4450.794062356, 't60', 60, 'mdepth', 17.96875, 'mfreq', 0.0, 'highx', 0.0, 'lowband', 2450.0822520097, 'earlydiff', 0.421875, 'midx', 0.5546875);" ],
[ 1327.596050859, 'me', "Ndef('reverb').set('wet', 0.9921875, 'lowx', 0.84375, 'amp', 0.66015625, 'damp', 0.31443298969072, 'size', 2.7938144329897, 'highband', 1024.0219794048, 't60', 60, 'mdepth', 4.639175257732, 'highx', 0.0, 'mfreq', 0.10309278350515, 'lowband', 2450.0822520097, 'fadeTime', 1, 'earlydiff', 0.421875, 'midx', 0.70618556701031);" ],
[ 1334.787668426, 'me', "d.proc_(WarpCutProc1.new)" ],
[ 1336.575512518, 'me', "f.proc_(WarpCutProc1.new)" ],
[ 1375.095159657, 'me', "c.tempoclock.schedAbs(c.tempoclock.nextBar, {
	Ndef(\\layers).add(Ndef(\\m1));
	nil;
});" ],
[ 1381.651343428, 'me', "c.tempoclock.schedAbs(c.tempoclock.nextBar, {
	Ndef(\\layers).add(Ndef(\\m0));
	nil;
});" ],
[ 1385.529423358, 'me', "Ndef('reverb').set('lowx', 0.84375, 'amp', 0.66015625, 'damp', 0.671875, 'size', 0.94921875, 'highband', 4450.794062356, 't60', 60, 'mdepth', 17.96875, 'mfreq', 0.0, 'highx', 0.0, 'lowband', 2450.0822520097, 'earlydiff', 0.421875, 'midx', 0.5546875);" ],
[ 1386.211702705, 'me', "Ndef('reverb').set('wet', 0.9921875, 'lowx', 0.84375, 'amp', 0.66015625, 'damp', 0.31443298969072, 'size', 2.7938144329897, 'highband', 1024.0219794048, 't60', 60, 'mdepth', 4.639175257732, 'highx', 0.0, 'mfreq', 0.10309278350515, 'lowband', 2450.0822520097, 'fadeTime', 1, 'earlydiff', 0.421875, 'midx', 0.70618556701031);" ],
[ 1392.659872441, 'me', "~yyy5.stop;
~yyy4.stop;
~yyy3.stop;
~yyy2.stop;
~yyy.stop;

~yyy5.clear;
~yyy4.clear;
~yyy3.clear;
~yyy2.clear;
~yyy.clear;" ],
[ 1396.476051339, 'me', "~n4.clear;" ],
[ 1398.834006282, 'me', "~n4.stop;" ],
[ 1408.21786309, 'me', "Pdef(\\aaa).stop;" ],
[ 1414.074202482, 'me', "Pdef(\\aaa, Pbind(
	\\instrument, \"granular_sampling\",
	\\trigger, 0.1,
	\\graindur, Pexprand(0.01 * ~pk, 10.9, inf),
	\\sndbuf, b,
	//\\pos, 0,
	\\pos, Pseq([1/4,1/2,3/4], inf),
	\\pan, 0,
	\\rate, Pseq([0.0625, 0.15]/4!4, inf),
	\\amp, Prand([0.15, 0.2, 0, 0.1, 0.412, 0.176, 1.2, 0.9], inf),
	\\envbuf, 5
));

Pdef(\\aaa).quant=1.2;" ],
[ 1417.231715127, 'me', "Pdef(\\aaa).playExt(c);" ],
[ 1430.444906426, 'me', "Pdef(\\a, Pbind(
	\\instrument, \"granular_sampling\",
	\\trigger, 8,
	\\graindur, Pexprand(0.1, 10.9, inf),
	\\sndbuf, ~bufferBag.take,
  \\transp, Prand([1/4,1/3,1/2,2/3,3/4,1]/~y*~x, inf),
	\\pos, 0,
	\\pan, Prand([-1, 0.2, 1, 0.4], inf),
	\\amp, Prand([0.5, 0.9], inf),
	\\envbuf, 2,
	\\dur, Prand([1+1/3,1/2,2/3,3/4,1]*12, inf),
));" ],
[ 1432.100855796, 'me', "Pdef(\\a).playExt(c);" ],
[ 1438.813651914, 'me', "Pdef(\\a2, Pbind(
	\\instrument, \"granular_sampling\",
	\\trigger, 8,
	\\graindur, Pexprand(1.1, ~y.abs, inf),
	\\sndbuf, ~takenBuf,
  \\transp, Prand([1/4,1/3,1/2,2/3,3/4,1]*~y*~x*10, inf),
	\\pos, 0,
	\\pan, Prand([1, -0.2, -1, -0.4], inf),
	\\amp, Prand([0.8, 0.9], inf),
	\\envbuf, 0,
	\\dur, Prand([1+1/3,1/2,2/3,3/4,1]*12, inf),
));" ],
[ 1439.963240496, 'me', "Pdef(\\a2).playExt(c);" ],
[ 1466.270160792, 'me', "Pdef(\\a2, Pbind(
	\\instrument, \"granular_sampling\",
	\\trigger, 8,
	\\graindur, Pexprand(1.1, ~y.abs, inf),
	\\sndbuf, ~takenBuf,
  \\transp, Prand([1/4,1/3,1/2,2/3,3/4,1]*~y*~x*10, inf),
  \\pos, Pexprand(0.00001,0.9),
	\\pan, Prand([1, -0.2, -1, -0.4], inf),
	\\amp, Prand([0.8, 0.9], inf),
	\\envbuf, 0,
	\\dur, Prand([1+1/3,1/2,2/3,3/4,1]*12, inf),
));" ],
[ 1514.866235761, 'me', "~r1" ],
[ 1519.002193527, 'me', "~ccd" ],
[ 1533.2646291, 'me', "Pdef(\\a, Pbind(
	\\instrument, \"granular_sampling\",
	\\trigger, 8,
  \\graindur, Pexprand(0.1, 10.9 / (~x.abs / ~ccd), inf),
	\\sndbuf, ~bufferBag.take,
  \\transp, Prand([1/4,1/3,1/2,2/3,3/4,1]/~y*~x, inf),
	\\pos, 0,
	\\pan, Prand([-1, 0.2, 1, 0.4], inf),
	\\amp, Prand([0.5, 0.9], inf),
	\\envbuf, 2,
	\\dur, Prand([1+1/3,1/2,2/3,3/4,1]*12, inf),
));" ],
[ 1555.919722439, 'me', "~y.abs / ~ccc" ],
[ 1559.931711672, 'me', "10.9 / (~y.abs / ~ccc)" ],
[ 1563.615042499, 'me', "Pdef(\\a2, Pbind(
	\\instrument, \"granular_sampling\",
	\\trigger, 8,
	\\graindur, Pexprand(0.1, 10.9 / (~y.abs / ~ccc), inf),
	\\sndbuf, ~takenBuf,
  \\transp, Prand([1/4,1/3,1/2,2/3,3/4,1]*~y*~x*10, inf),
  \\pos, Pexprand(0.00001,0.9),
	\\pan, Prand([1, -0.2, -1, -0.4], inf),
	\\amp, Prand([0.8, 0.9], inf),
	\\envbuf, 0,
	\\dur, Prand([1+1/3,1/2,2/3,3/4,1]*12, inf),
));" ],
[ 1588.290966821, 'me', "0.01 * ~pk" ],
[ 1598.043802409, 'me', "~ccd/~pk" ],
[ 1602.927630447, 'me', "~ccd/~pk*~x" ],
[ 1610.466992314, 'me', "2000/~ccd/~pk*~x" ],
[ 1616.177329474, 'me', "200/~ccd/~pk*~x" ],
[ 1618.70049827, 'me', "Pdef(\\aaa, Pbind(
	\\instrument, \"granular_sampling\",
	\\trigger, 0.1,
	\\graindur, Pexprand(0.01 * ~pk, 200/~ccd/~pk*~x, inf),
	\\sndbuf, b,
	//\\pos, 0,
	\\pos, Pseq([1/4,1/2,3/4], inf),
	\\pan, 0,
	\\rate, Pseq([0.0625, 0.15]/4!4, inf),
	\\amp, Prand([0.15, 0.2, 0, 0.1, 0.412, 0.176, 1.2, 0.9], inf),
	\\envbuf, 5
));" ],
[ 1639.978982226, 'me', "~ccc * [1/4,1/3,1/2,2/3,3/4,1]/~x/~y" ],
[ 1646.589758996, 'me', "~ccd * [1/4,1/3,1/2,2/3,3/4,1]/~x/~y" ],
[ 1651.660166031, 'me', "~n4.stop;" ],
[ 1652.086096963, 'me', "~n4.clear;" ],
[ 1653.973959194, 'me', "~n4 = Pbind(
	\\instrument, \"granular_sampling\",
	\\trigger,~x/~r1 * 18,
	\\graindur, Ndef(\\pm_l2b),
	\\sndbuf, b,
	\\transp, Prand(~ccd * [1/4,1/3,1/2,2/3,3/4,1]/~x/~y, inf),
	//\\pos, 0,
	\\pos, Pseq([1/4,1/2,3/4], inf),
	\\pan, Prand([-1, 1, 0.2, -0.2, 0.5, -0.5], inf),
	\\amp, Prand([1.5, 1.9], inf),
	\\envbuf, 1,
	\\dur, Prand([1+1/3,1/2,2/3,3/4,1]/~y, inf),
);" ],
[ 1656.914254567, 'me', "~n4.playExt(c);" ],
[ 1705.063745625, 'me', "10.9 / (~y.abs / ~rlpf)" ],
[ 1711.291323277, 'me', "1.9 / (~y.abs / ~rlpf)" ],
[ 1720.737025232, 'me', " 1.9 / (~x.abs+~y.abs / ~rlpf)" ],
[ 1725.452143024, 'me', "0.9 / (~x.abs+~y.abs / ~rlpf)" ],
[ 1729.867925698, 'me', "0.9 + (~x.abs+~y.abs / ~rlpf)" ],
[ 1732.794212542, 'me', "Pdef(\\a2, Pbind(
	\\instrument, \"granular_sampling\",
	\\trigger, 8,
	\\graindur, Pexprand(0.1, 0.9 + (~x.abs+~y.abs / ~rlpf), inf),
	\\sndbuf, ~takenBuf,
  \\transp, Prand([1/4,1/3,1/2,2/3,3/4,1]*~y*~x*10, inf),
  \\pos, Pexprand(0.00001,0.9),
	\\pan, Prand([1, -0.2, -1, -0.4], inf),
	\\amp, Prand([0.8, 0.9], inf),
	\\envbuf, 0,
	\\dur, Prand([1+1/3,1/2,2/3,3/4,1]*12, inf),
));" ],
[ 1743.314878025, 'me', "c.tempoclock.schedAbs(c.tempoclock.nextBar, {
	Ndef(\\layers).add(Ndef(\\l0));
	nil;
});" ],
[ 1746.374703178, 'me', "c.tempoclock.schedAbs(c.tempoclock.nextBar, {
	Ndef(\\layers).add(Ndef(\\ll2));
	nil;
});" ],
[ 1749.325580686, 'me', "c.tempoclock.schedAbs(c.tempoclock.nextBar, {
	Ndef(\\layers).add(Ndef(\\hh2));
	nil;
});" ],
[ 1751.863994638, 'me', "c.tempoclock.schedAbs(c.tempoclock.nextBar, {
	Ndef(\\layers).add(Ndef(\\hh1));
	nil;
});" ],
[ 1756.773720131, 'me', "c.tempoclock.schedAbs(c.tempoclock.nextBar, {
	Ndef(\\layers).add(Ndef(\\h0));
	nil;
});" ],
[ 1759.192365688, 'me', "a.set(\\tempo, [0.25, 45/60, 10/7, 6/10, 7/10, 0.7, 1.1, 1.7, 2.2, 2.7, 2.4, 4.7].choose);" ],
[ 1761.617670717, 'me', "f.stop;" ],
[ 1764.33271002, 'me', "f.play(c);" ],
[ 1765.454760614, 'me', "f.proc_(WarpCutProc1.new)" ],
[ 1767.661686816, 'me', "d.stop;" ],
[ 1767.978711548, 'me', "d.play(c);" ],
[ 1769.275839279, 'me', "d.proc_(WarpCutProc1.new)" ],
[ 1775.963670139, 'me', "d.proc_(SQPusher1.new)" ],
[ 1777.931592489, 'me', "f.proc_(SQPusher1.new)" ],
[ 1781.659399828, 'me', "g.stop;" ],
[ 1782.653376639, 'me', "g.play(c);" ],
[ 1783.563651398, 'me', "g.proc_(SQPusher1.new)" ],
[ 1790.838017338, 'me', "Ndef('reverb').set('wet', 0.9921875, 'lowx', 0.84375, 'amp', 0.66015625, 'damp', 0.31443298969072, 'size', 2.7938144329897, 'highband', 1024.0219794048, 't60', 60, 'mdepth', 4.639175257732, 'highx', 0.0, 'mfreq', 0.10309278350515, 'lowband', 2450.0822520097, 'fadeTime', 1, 'earlydiff', 0.421875, 'midx', 0.70618556701031);" ],
[ 1792.791578857, 'me', "Ndef('reverb').set('lowx', 0.84375, 'amp', 0.66015625, 'damp', 0.671875, 'size', 0.94921875, 'highband', 4450.794062356, 't60', 60, 'mdepth', 17.96875, 'mfreq', 0.0, 'highx', 0.0, 'lowband', 2450.0822520097, 'earlydiff', 0.421875, 'midx', 0.5546875);" ],
[ 1794.294929496, 'me', "Ndef('reverb').set('wet', 0.9921875, 'lowx', 0.84375, 'amp', 0.66015625, 'damp', 0.31443298969072, 'size', 2.7938144329897, 'highband', 1024.0219794048, 't60', 60, 'mdepth', 4.639175257732, 'highx', 0.0, 'mfreq', 0.10309278350515, 'lowband', 2450.0822520097, 'fadeTime', 1, 'earlydiff', 0.421875, 'midx', 0.70618556701031);" ],
[ 1796.78511783, 'me', "Ndef('reverb').set('lowx', 0.84375, 'amp', 0.66015625, 'damp', 0.671875, 'size', 0.94921875, 'highband', 4450.794062356, 't60', 60, 'mdepth', 17.96875, 'mfreq', 0.0, 'highx', 0.0, 'lowband', 2450.0822520097, 'earlydiff', 0.421875, 'midx', 0.5546875);" ],
[ 1819.123745566, 'me', "(
~yyy = Pbind(
	\\instrument, \"grain-asr\",
	\\buffer, b,
	\\startPos, Pseq([0.4, 0.32, 0.6215, 0.8], inf) + Pwhite(0.0, 0.1),
  \\dur, Pexprand(0.3,4),
	\\att, 4.001,
	\\rel, 11,
	\\rate, Prand([Pn(2, 4), 1, 4], inf),
	\\amp, 1.75,
	\\pan, Pwhite(-1.0, 1.0),
	\\legato, 0
);
)" ],
[ 1823.48156247, 'me', "~yyy.playExt(c);" ],
[ 1843.922868902, 'me', "Ndef(\\layers).add(Ndef(\\lc2));" ],
[ 1864.055721142, 'me', "Ndef(\\layers).add(Ndef(\\lc1));" ],
[ 1900.18100061, 'me', "    Ndef(\\t1).fadeTime = 5;
        Ndef(\\t1, { |amp = 0.82, lpf = 10500, win = 0.5, dell = 2.0, delm = 7.0, pit = 2|
          var src = Ndef(\\mm1).ar * \\amp.kr(1.5);
          Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(src, win, [Vibrato.kr(0.55, 1.5, 0.09, ~y),Vibrato.kr(Line.kr(10,5,100), 16, 0.9)], 2, 40), [Vibrato.kr(1, 12 * ~y, Line.kr(10, 0.02, 100)), Vibrato.kr(10,6, 1.12)])),[Line.kr(-1,1,500, doneAction: 0), Line.kr(1, -1, 500, doneAction: 0)],1.5);
        });" ],
[ 1916.686154257, 'me', "Ndef(\\t1, { |amp = 0.82, lpf = 10500, win = 0.5, dell = 2.0, delm = 7.0, pit = 2|
          var src = Ndef(\\mm1).ar * \\amp.kr(0.5);
          Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(src, win, [Vibrato.kr(0.55, 1.5, 0.09, ~y),Vibrato.kr(Line.kr(10,5,100), 16, 0.9)], 2, 40), [Vibrato.kr(1, 12 * ~y, Line.kr(10, 0.02, 100)), Vibrato.kr(10,6, 1.12)])),[Line.kr(-1,1,500, doneAction: 0), Line.kr(1, -1, 500, doneAction: 0)],1.5);
        });" ],
[ 1940.521061506, 'me', "a.set(\\tempo,0.125);" ],
[ 1949.669999924, 'me', "g.proc_(OffsetCP1.new)" ],
[ 1954.33886692, 'me', "d.proc_(OffsetCP1.new)" ],
[ 1956.212927536, 'me', "f.proc_(OffsetCP1.new)" ],
[ 1970.481511085, 'me', "Ndef(\\layers).release(50);" ],
[ 1978.332695504, 'me', "~yyy5.release(10);
~yyy4.release(10);
~yyy3.release(10);
~yyy2.release(10);
~yyy.release(10);" ],
[ 1998.539499689, 'me', "~yyy5.stop;
~yyy4.stop;
~yyy3.stop;
~yyy2.stop;
~yyy.stop;

~yyy5.clear;
~yyy4.clear;
~yyy3.clear;
~yyy2.clear;
~yyy.clear;" ],
[ 2010.967691079, 'me', "Ndef(\\layers).removeAll;" ],
[ 2018.582810087, 'me', "Ndef('reverb').set('lowx', 0.609375, 'amp', 0.38092041015625, 'damp', 0.2890625, 'size', 0.6171875, 'highband', 7233.9416273667, 't60', 4.0375572334984, 'mdepth', 0.0, 'mfreq', 2.03125, 'highx', 0.2265625, 'lowband', 681.56675509913, 'fadeTime', 1, 'earlydiff', 0.765625, 'midx', 0.515625);" ],
[ 2028.469178212, 'me', "Pdef(\\a).stop;" ],
[ 2032.593716873, 'me', "Pdef(\\aaa).stop;" ],
[ 2039.50676002, 'me', "Pdef(\\a2).stop;" ],
[ 2047.922684914, 'me', "~n4.stop;" ],
[ 2089.479630327, 'me', "Ndef('reverb').set('lowx', 0.84375, 'amp', 0.66015625, 'damp', 0.875, 'size', 0.5, 'highband', 5829.4153471361, 't60', 0.16483258382257, 'mdepth', 17.96875, 'mfreq', 0.0, 'highx', 0.0, 'lowband', 100.0, 'fadeTime', 1, 'earlydiff', 0.703125, 'midx', 0.5546875);" ],
[ 2093.590713936, 'me', "f.stop;" ],
[ 2096.132630841, 'me', "d.stop;" ],
[ 2098.301566182, 'me', "i.stop;" ],
[ 2100.198661959, 'me', "k.stop;" ],
[ 2102.00161658, 'me', "g.stop;" ],
[ 2156.599165803, 'me', "History.playCmdPeriod" ],
[ 2156.599524542, 'me', "History.playCmdPeriod" ],
