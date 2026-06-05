import { useEffect, useState } from 'react';
import { Button } from '@/components/ui/button';
import { getSessions, switchToSession, logoutSession } from '@/lib/api';
import type { SessionData } from '@/lib/api';
import { LogOut, User } from 'lucide-react';

const SessionSwitcher = () => {
  const [sessions, setSessions] = useState<SessionData[]>([]);
  const [currentRole, setCurrentRole] = useState<string>('');

  useEffect(() => {
    const loadSessions = () => {
      const allSessions = getSessions();
      setSessions(allSessions);

      // Check sessionStorage first (per-tab), then localStorage
      let current = sessionStorage.getItem('orientai_user');
      if (!current) {
        current = localStorage.getItem('orientai_user');
      }

      if (current) {
        try {
          const user = JSON.parse(current);
          setCurrentRole(user.role);
        } catch {
          // Ignore parsing errors
        }
      }
    };

    loadSessions();

    // Listen for storage changes (cross-tab communication)
    window.addEventListener('storage', loadSessions);

    // Also listen for sessionStorage changes in this tab
    const timer = setInterval(loadSessions, 500);

    return () => {
      window.removeEventListener('storage', loadSessions);
      clearInterval(timer);
    };
  }, []);

  if (sessions.length <= 1) {
    return null;
  }

  const handleSwitch = (role: string) => {
    if (switchToSession(role)) {
      setCurrentRole(role);
      // Don't reload, just update the state
      // The app will re-render with the new token/user from sessionStorage
    }
  };

  const handleLogout = (role: string, e: React.MouseEvent) => {
    e.stopPropagation();
    logoutSession(role);
    setSessions(sessions.filter(s => s.role !== role));
  };

  return (
    <div className="fixed bottom-4 left-4 z-50 space-y-2">
      <div className="text-xs font-semibold text-muted-foreground uppercase tracking-wider mb-2">
        Sessions ({sessions.length})
      </div>
      {sessions.map((session) => (
        <div
          key={session.role}
          className={`rounded-lg border p-3 text-sm transition-all ${
            currentRole === session.role
              ? 'bg-primary/10 border-primary'
              : 'bg-card border-border hover:border-primary'
          }`}
        >
          <div className="flex items-center justify-between gap-2">
            <div className="flex items-center gap-2 flex-1">
              <User className="h-3.5 w-3.5 text-muted-foreground" />
              <div className="flex-1 min-w-0">
                <div className="font-medium truncate">{session.user.email}</div>
                <div className="text-xs text-muted-foreground capitalize">{session.role}</div>
              </div>
              {currentRole === session.role && (
                <div className="text-xs font-semibold text-primary">Actif</div>
              )}
            </div>
          </div>
          <div className="flex gap-1 mt-2">
            {currentRole !== session.role && (
              <Button
                size="sm"
                variant="outline"
                className="flex-1 text-xs h-7"
                onClick={() => handleSwitch(session.role)}
              >
                Basculer
              </Button>
            )}
            <Button
              size="sm"
              variant="ghost"
              className="h-7 w-7 p-0"
              onClick={(e) => handleLogout(session.role, e)}
              title="Déconnecter cette session"
            >
              <LogOut className="h-3.5 w-3.5 text-destructive" />
            </Button>
          </div>
        </div>
      ))}
    </div>
  );
};

export default SessionSwitcher;
