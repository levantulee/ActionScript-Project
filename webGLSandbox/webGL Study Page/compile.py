from json import dumps
from os.path import splitext, abspath, dirname, join
from os import listdir
import re

if __name__ == '__main__':
    here = dirname(
        abspath(__file__)
    )

    shaders = {}
    sectionre = re.compile('^(\w+):$')
    files = []
            
    directives = '\n'.join([
        '#version 100',
        '#ifdef GL_ES',
        'precision highp int;',
        'precision highp float;',
        'precision highp vec2;',
        'precision highp vec3;',
        'precision highp vec4;',
        'precision highp ivec2;',
        'precision highp ivec3;',
        'precision highp ivec4;',
        '#endif',
    ])

    for name in listdir(here):
        if name.endswith('.shader'):
            fullname = join(here, name)
            shortname = splitext(name)[0]
            source = open(fullname).read()
            lines = source.split('\n')
            type = None
            types = {None: ''}
            filenum = len(files)
            for linenum, line in enumerate(lines):
                line = line.strip()
                if not line:
                    continue
                if line.startswith('//'):
                    continue

                match = sectionre.match(line)
                if match:
                    type = match.group(1)
                    types.setdefault(type, '')
                elif type:
                    types[type] += '#line %i %i\n%s\n'  % (linenum, filenum, line.strip())
            
            files.append({
                'name': shortname, 
                'path': fullname,
                'lines': lines,
                'fragment': '%s\n%s' % (directives, types['fragment']),
                'vertex': '%s\n%s' % (directives, types['vertex']),
            })

    open(join(here, 'shaders.json'), 'w').write(dumps(files))
