import { useEffect, useState } from 'react';
import { tests as testsApi, auth as authApi } from '@/lib/api';

// Cache per-user para evitar múltiples llamadas API
const testCompletionCacheByUser: Record<string, {
  hasCompleted: boolean | null;
  error: string | null;
  promise: Promise<any> | null;
}> = {};

// Función para obtener la clave de caché basada en el usuario actual
const getCacheKey = async (): Promise<string> => {
  try {
    const user = await authApi.me() as any;
    return user?.user?.id || user?.id || 'anonymous';
  } catch {
    return 'anonymous';
  }
};

// Función para reiniciar el caché del usuario actual
export const invalidateTestCompletionCache = () => {
  // Clear all caches - will be recomputed on next use
  Object.keys(testCompletionCacheByUser).forEach(key => {
    testCompletionCacheByUser[key] = {
      hasCompleted: null,
      error: null,
      promise: null,
    };
  });
};

export const useTestCompletion = () => {
  const [hasCompletedTest, setHasCompletedTest] = useState<boolean | null>(null);
  const [testLoading, setTestLoading] = useState(true);
  const [testError, setTestError] = useState<string | null>(null);
  const [cacheKey, setCacheKey] = useState<string | null>(null);

  useEffect(() => {
    let cancelled = false;

    const checkTestCompletion = async () => {
      try {
        setTestLoading(true);

        // Get user ID first
        const user = await authApi.me() as any;
        const userId = user?.user?.id || user?.id || 'anonymous';
        setCacheKey(userId);

        // Initialize cache for this user if not exists
        if (!testCompletionCacheByUser[userId]) {
          testCompletionCacheByUser[userId] = {
            hasCompleted: null,
            error: null,
            promise: null,
          };
        }

        const userCache = testCompletionCacheByUser[userId];

        // Si le cache a déjà les données, utilise-les immédiatement
        if (userCache.hasCompleted !== null && !cancelled) {
          setHasCompletedTest(userCache.hasCompleted);
          setTestError(userCache.error);
          setTestLoading(false);
          return;
        }

        // Si une requête est déjà en cours, attends le résultat
        if (userCache.promise) {
          await userCache.promise;
          if (!cancelled) {
            setHasCompletedTest(userCache.hasCompleted);
            setTestError(userCache.error);
            setTestLoading(false);
          }
          return;
        }

        // Sinon, lance une nouvelle requête
        const loadTestHistory = async () => {
          try {
            const history = await testsApi.getHistory();
            const sessions = Array.isArray(history?.sessions) ? history.sessions : [];

            // Check if there's at least one completed test session for this user (including orientation test)
            const hasCompleted = sessions.some((session: any) => session.complete === true);

            // Sauvegarde dans le cache utilisateur
            userCache.hasCompleted = hasCompleted;
            userCache.error = null;

            if (!cancelled) {
              setHasCompletedTest(hasCompleted);
              setTestError(null);
            }
          } catch (err) {
            const errorMessage = err instanceof Error ? err.message : 'Impossible de vérifier le statut du test.';

            // Sauvegarde l'erreur dans le cache utilisateur
            userCache.error = errorMessage;
            userCache.hasCompleted = false;

            if (!cancelled) {
              setTestError(errorMessage);
              setHasCompletedTest(false);
            }
          } finally {
            userCache.promise = null;
            if (!cancelled) setTestLoading(false);
          }
        };

        // Crée et sauvegarde la promesse
        userCache.promise = loadTestHistory();
      } catch (err) {
        if (!cancelled) {
          const errorMessage = err instanceof Error ? err.message : 'Impossible de charger le profil utilisateur.';
          setTestError(errorMessage);
          setHasCompletedTest(false);
          setTestLoading(false);
        }
      }
    };

    checkTestCompletion();

    return () => {
      cancelled = true;
    };
  }, []);

  return { hasCompletedTest, testLoading, testError };
};
