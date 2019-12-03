#include <iostream>
#include <map>
#include <string>
#include <vector>

using namespace std;

int main () {

  string s;

  cin >> s;

  for(int i = (int)s.size() - 1; i >= 0; i--) {
    if(s[i] <= 10 || s[i] == ' ')
      s.erase(s.begin() + i);
  }

  s.push_back('#');
  int cnt = 1;
  char last = s[0];
  vector<pair<int, char> > ans;
  for(int i = 1; i < s.size(); i++) {
    char c = s[i];
    if(last == c) 
      cnt++;
    else {
      ans.push_back(pair<int, char>(cnt, last));
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
    if(m.count(x.second)) {
      cout << m[x.second] << (x.first > 1 ? (" " + to_string(x.first)) : "") << endl;
    } else {
      while(x.first--) {
        cout << m2[x.second] << endl;
      }
    }
  }

}