import { useState, useEffect, useCallback, useRef } from 'react';

interface UseInfiniteScrollOptions {
  initialPageSize?: number;
  threshold?: number; // Distance from bottom to trigger load (pixels)
}

export function useInfiniteScroll<T>(
  fetchData: (skip: number, limit: number) => Promise<T[]>,
  options: UseInfiniteScrollOptions = {}
) {
  const { initialPageSize = 20, threshold = 300 } = options;

  const [items, setItems] = useState<T[]>([]);
  const [skip, setSkip] = useState(0);
  const [isLoading, setIsLoading] = useState(false);
  const [hasMore, setHasMore] = useState(true);
  const [error, setError] = useState<Error | null>(null);
  const observerTarget = useRef<HTMLDivElement>(null);
  const isInitialLoad = useRef(true);

  const loadMore = useCallback(async () => {
    setIsLoading(true);
    setError(null);

    try {
      const newItems = await fetchData(skip, initialPageSize);

      if (newItems.length < initialPageSize) {
        setHasMore(false);
      }

      setItems(prev => [...prev, ...newItems]);
      setSkip(prev => prev + initialPageSize);
    } catch (err) {
      setError(err instanceof Error ? err : new Error('Unknown error'));
    } finally {
      setIsLoading(false);
    }
  }, [skip, fetchData, initialPageSize]);

  // Load initial data once on mount
  useEffect(() => {
    if (isInitialLoad.current) {
      isInitialLoad.current = false;
      loadMore();
    }
  }, []);

  // Setup Intersection Observer for bottom detection
  useEffect(() => {
    const observer = new IntersectionObserver(
      entries => {
        if (entries[0].isIntersecting && hasMore && !isLoading) {
          loadMore();
        }
      },
      { rootMargin: `${threshold}px` }
    );

    if (observerTarget.current) {
      observer.observe(observerTarget.current);
    }

    return () => {
      if (observerTarget.current) {
        observer.unobserve(observerTarget.current);
      }
    };
  }, [loadMore, hasMore, isLoading, threshold]);

  const reset = useCallback(() => {
    setItems([]);
    setSkip(0);
    setIsLoading(false);
    setHasMore(true);
    setError(null);
    isInitialLoad.current = true;
  }, []);

  return {
    items,
    isLoading,
    hasMore,
    error,
    observerTarget,
    loadMore,
    reset,
    setItems,
  };
}
