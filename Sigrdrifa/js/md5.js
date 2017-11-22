// this file for support md5 encrypt in Javascript
// algorithm comes from https://en.wikipedia.org/wiki/MD5
function str2bin (a) {
  var i;
  var b = '';
  for (i = 0; i < a.length; i=i+1) {
    b = b + ((a.charCodeAt(i) & 0xff)>>>0).toString(2);
  }
  return b
}
function bitadd(a,b){
  if(a+b > 0xffffffff)
  {
    return a+b-0xffffffff-1;
  }
  return a+b;
}
function bitappend(a,b)
{
  return a+b;
}
function bit64(a){
  var b = (a>>>0).toString(2);
  while(b.length<64)
  {
    b = '0' + b;
  }
  return b;
}
function hex8(a){
  var b = (a>>>0).toString(16);
  while(b.length<8)
  {
    b = '0' + b;
  }
  return b;
}
function leftrotate(a,b){
  var l = (a << b) & 0xffffffff;
  var r = (a >>> (32-b)) & 0xffffffff;
  var m = l | r;
  return m;
}

var s = [7, 12, 17, 22,  7, 12, 17, 22,  7, 12, 17, 22,  7, 12, 17, 22,
         5,  9, 14, 20,  5,  9, 14, 20,  5,  9, 14, 20,  5,  9, 14, 20,
         4, 11, 16, 23,  4, 11, 16, 23,  4, 11, 16, 23,  4, 11, 16, 23,
         6, 10, 15, 21,  6, 10, 15, 21,  6, 10, 15, 21,  6, 10, 15, 21];

var K = [0xd76aa478, 0xe8c7b756, 0x242070db, 0xc1bdceee,
         0xf57c0faf, 0x4787c62a, 0xa8304613, 0xfd469501,
         0x698098d8, 0x8b44f7af, 0xffff5bb1, 0x895cd7be,
         0x6b901122, 0xfd987193, 0xa679438e, 0x49b40821,
         0xf61e2562, 0xc040b340, 0x265e5a51, 0xe9b6c7aa,
         0xd62f105d, 0x02441453, 0xd8a1e681, 0xe7d3fbc8,
         0x21e1cde6, 0xc33707d6, 0xf4d50d87, 0x455a14ed,
         0xa9e3e905, 0xfcefa3f8, 0x676f02d9, 0x8d2a4c8a,
         0xfffa3942, 0x8771f681, 0x6d9d6122, 0xfde5380c,
         0xa4beea44, 0x4bdecfa9, 0xf6bb4b60, 0xbebfbc70,
         0x289b7ec6, 0xeaa127fa, 0xd4ef3085, 0x04881d05,
         0xd9d4d039, 0xe6db99e5, 0x1fa27cf8, 0xc4ac5665,
         0xf4292244, 0x432aff97, 0xab9423a7, 0xfc93a039,
         0x655b59c3, 0x8f0ccc92, 0xffeff47d, 0x85845dd1,
         0x6fa87e4f, 0xfe2ce6e0, 0xa3014314, 0x4e0811a1,
         0xf7537e82, 0xbd3af235, 0x2ad7d2bb, 0xeb86d391];


//Pre-processing: adding a single 1 bit
function md5(a){
  a = unescape(encodeURIComponent(a)); // decode
  a = str2bin(a);
  //Initialize variables:
  var a0 = 0x67452301;   //A
  var b0 = 0xefcdab89;   //B
  var c0 = 0x98badcfe;   //C
  var d0 = 0x10325476;   //D
  var oa = a;
  a = bitappend(a, '1');
  while (a.length%512!=448) {
    a = bitappend(a, '0');
  }
  a = a + bit64(oa.length);
  //Process the message in successive 512-bit chunks:
  var i = 0;
  var aa = []; // array for storing every 512 bit of a;
  for(i=0; i<a.length; i=i+512){
    aa[Math.ceil(i/512)] = a.slice(i,i+511);
  }
  for(var j=0; j<aa.length; j=j+1){
    //break chunk into sixteen 32-bit words M[x], 0 ≤ x ≤ 15
    i = 0;
    var M = [];
    for(i=0; i<512; i=i+32){
      M[Math.ceil(i/32)] = parseInt(aa[j].slice(i,i+15),16);
    }
    //Initialize hash value for this chunk:
    var A = a0;
    var B = b0;
    var C = c0;
    var D = d0;
    for(i=0; i<64; i=i+1){
      var F=0;
      var g=0;
      if(0<=i<=15){
        F = (B & C) | ((~B) & D) & 0xffffffff;
        g = i;
      }
      else if(16<=i<=31){
        F = (D & B) | ((~D) & C) & 0xffffffff;
        g = (5*i + 1) % 16;
      }
      else if(32<=i<=47){
        F = B ^ C ^ D & 0xffffffff;
        g = (3*i + 5) % 16;
      }
      else if(48<=i<=63){
        F = C ^ (B | (~D)) & 0xffffffff;
        g = (7*i) % 16;
      }
      F = bitadd(bitadd(bitadd(F,A),K[i]),M[g]) ;
      A = D;
      D = C;
      C = B;
      B = bitadd(B,leftrotate(F, s[i]));
    }
    a0 = a0 + A;
    b0 = b0 + B;
    c0 = c0 + C;
    d0 = d0 + D;
  }
  console.log(a0.toString(16));
  console.log(a0);
  console.log(b0.toString(16));
  console.log(b0);
  console.log(c0.toString(16));
  console.log(c0);
  console.log(d0.toString(16));
  console.log(d0);
  var digest = hex8(a0) + hex8(b0) + hex8(c0) + hex8(d0);
  return digest;
}
