#include <bits/stdc++.h>

using namespace std;

#define INF (1ll << 62)
#define pb push_back
#define ii pair<int,int>
#define OK cerr <<"OK"<< endl
#define debug(x) cerr << #x " = " << (x) << endl
#define ff first
#define ss second
#define int long long
#define tt tuple<int, int, int>
#define endl '\n'

signed main () {
  
  ios_base::sync_with_stdio(false);
  cin.tie(NULL);

  string s;

  cin >> s;

  for(int i = (int)s.size() - 1; i >= 0; i--) {
    if(s[i] <= 10 || s[i] == ' ')
      s.erase(s.begin() + i);
  }

  s.pb('#');
  int cnt = 1;
  char last = s[0];
  vector<pair<int, char> > ans;
  for(int i = 1; i < s.size(); i++) {
    char c = s[i];
    if(last == c) 
      cnt++;
    else {
      ans.pb(ii(cnt, last));
      cnt = 1;
    }

    last = c;
  }

  map<char, string> m;
  map<char, string> m2;
  m['+'] = "inc";
  m['-'] = "dec";
  m['>'] = "fwd";
  m['<'] = "rwd";

  m2['.'] = "write";
  m2[','] = "read";

  m2['['] = "begin";
  m2[']'] = "end";

  for(pair<int, char> x: ans) {
    if(m.count(x.ss)) {
      cout << m[x.ss] << (x.ff > 1 ? (" " + to_string(x.ff)) : "") << endl;
    } else {
      while(x.ff--) {
        cout << m2[x.ss] << endl;
      }
    }
  }

}