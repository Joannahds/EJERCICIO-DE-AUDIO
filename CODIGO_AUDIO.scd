s.boot;


s.waitForBoot {
    // El archivo de audio en un Buffer
    ~buf = Buffer.read(s, "C:/Users/DELL/Downloads/fat-kick-drumloop-99bpm-141016.wav");


    SynthDef(\samplePlayer, {
        |bufnum, rate = 1, amp = 0.5, startPos = 0|
        var sound = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum) * rate, startPos * BufFrames.kr(bufnum), doneAction: 2);
        Out.ar(0, sound * amp);
    }).add;


    s.sync;

    // Define la secuencia Pdef
    Pdef(\sampleSeq,
        Pbind(
            \instrument, \samplePlayer,
            \bufnum, ~buf,
            \dur, Pseq([1, 2, 0.5, 0.25], inf), // Duraciones en segundos
            \amp, Pseq([0.5, 0.7, 0.4, 0.6], inf), // Amplitudes
            \rate, Pseq([1, 0.5, 1.5, 2], inf), // Velocidades de reproducción
            \startPos, Pseq([0, 0.25, 0.5, 0.75], inf) // Posiciones iniciales como fracción de la longitud del buffer
        )
    );

    // Iniciar la secuencia
    Pdef(\sampleSeq).play;
};

Pdef(\sampleSeq).stop;
